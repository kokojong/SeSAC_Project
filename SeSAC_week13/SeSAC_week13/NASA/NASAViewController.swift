//
//  NASAViewController.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/22.
//
import UIKit

class NASAViewController: BaseViewController {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    var session: URLSession!
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = "\(result*100)%"
        }
    }
    
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 이미 BaseVC에서 부르기 때문에 부를 필요가 x
//        configure()
//        setupConstraint()
        
        buffer = Data()
        
        request()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        session.invalidateAndCancel() // 사라질 때 정리를 해줘야함 (리소스 정리 -> 실행중인것도 무시)
        // 기획에 따라 내용을 달리해야한다(카톡 이미지 다운받다가 다른 톡방 켜기 등)
        
        // 기다렸다가 끝나면 정리해주기
        session.finishTasksAndInvalidate()
        
    }
    
    override func configure() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        
        label.textAlignment = .center
        label.backgroundColor = .yellow
    }
    
    override func setupConstraint() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
    }
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_2980.jpg")!
        
//        URLSession.shared.dataTask(with: url).resume() // trigger
        // shared를 쓰면 세부적인 조절이 불가능하다
        /*
        let configure = URLSessionConfiguration.default
        configure.allowsCellularAccess = false
        URLSession(configuration: configure).dataTask(with: url).resume()
         */
//        URLSessionConfiguration.default  // 이렇게 설정도 가능
//        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: url).resume()
        
        session =  URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume() // 나중에 다시 부를수 있도록 처리
        
        
        

        
    }
}

extension NASAViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답받은 경우에 호출(상태 코드)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print(response)
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            // Content-Length 가 존재
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("data : ",data)
        buffer?.append(data)
    }
    
    // 응답이 완료되면 : error가 없으니까 nil
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("error 발생",error)
        } else {
            print("성공") // completion Handler의 부분
            
            guard let buffer = buffer else {
                print("buffer error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
    
}
