//
//  ConcurrencyViewController.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/12.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    
    @IBOutlet weak var imageview1: UIImageView!
    @IBOutlet weak var imageview3: UIImageView!
    @IBOutlet weak var imageview2: UIImageView!
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func basic(_ sender: UIButton) {
        
        print("hello world")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        print("")
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("byebye world")
        
    }
    
    @IBAction func mainSync(_ sender: UIButton) {
        
        print("hello world")
        
        // 다른거에 던져주고 내가 할거 먼저함(101~200을 먼저)
        // 던져놓고 보니까 내꺼잖아? -> 수행
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        print("")
//        DispatchQueue.main.sync { // dead lock이 걸린다 (큐에 던지고 기다리는데 큐에서는 또 메인이 기다리는 거라서 무한 기다림)
            for i in 101...200 {
                print(i, terminator: " ")
            }
            
            print("byebye world")
//        }
        
        
    }
    
    @IBAction func globalSyncAsync(_ sender: UIButton) {
        
        print("hello world")
        
        // global sync -> 결국 메인에서 하는거랑 비슷하지 않나?
        // 다른 쓰레드로 동기적으로 보내는 코드라도 실질적으로는 메인 쓰레드에서 일하게 함
        //
//        DispatchQueue.global().sync {
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
            
        }
        
       
        print("")
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("byebye world")
        
        
    }
    
    @IBAction func globalQoS(_ sender: UIButton) {
    
//        let queue = DispatchQueue(label: "kokojong") // serial
        let queue = DispatchQueue(label: "kokojong2", qos: .utility, attributes: .concurrent) // 우선순위등을 정할수 있음
        
        
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        queue.async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        print("끝?")
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
    
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("\n진짜 끝")
            self.view.backgroundColor = .lightGray
        }
        
    }
    
    @IBAction func nasa(_ sender: UIButton) {
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { imag in
//                    print("3")
//                }
//            }
//        }
        
        let group = DispatchGroup()
        
        //
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url1) { image in
//                print("1")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url1) { image in
//                print("2")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url1) { image in
//                print("3")
//            }
//        }
//
//        group.notify(queue: .main) {
//            print("완료")
//        }
        
        group.enter()
        request(url: url1) { image in
            print("1")
            group.leave()
        }
        
        group.enter()
        request(url: url2) { image in
            print("2")
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            print("3")
            group.leave()
        }
        group.notify(queue: .main) {
            print("완료")
        }
        
    }
    
    @IBAction func asyncAwait(_ sender: UIButton) {
        
        // async await를 할때는 이렇게 사용하라
        Task {
            do {
                let newRequest1 = try await newRequest(url: url1)
                let newRequest2 = try await newRequest(url: url2)
                let newRequest3 = try await newRequest(url: url3)
                
                imageview1.image = newRequest1
                imageview2.image = newRequest2
                imageview3.image = newRequest3
                
            } catch {
                
            }
        }
        
    }
    
    // 비동기시에 발생할 수 있는 문제
    @IBAction func raceCondition(_ sender: UIButton) {
        
        var nickname = "kokojong"
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "뿌엥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "밥밥"
            print("second: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
        
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }

            let image = UIImage(data: data)
            completionHandler(image)
                                  
        }.resume()
    }
    
    // async throws - 에러를 여러개 던진
    func newRequest(url: URL) async throws -> UIImage {
     
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.statusError
        }
        
        guard let image = UIImage(data: data) else {
            throw APIError.unSupportedImage
        }
        
        return image
    }
}

enum APIError: Error {
    case statusError
    case unSupportedImage
}
