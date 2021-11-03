//
//  ContentViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit
import RealmSwift

class ContentViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "content"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action:#selector(closeButtonClicked) )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked) )
        
        print("Realm:",localRealm.configuration.fileURL!)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
    }
    
    @objc func closeButtonClicked() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func saveButtonClicked() {
        
        print("saved")
        
        let task = UserDiary(diaryTitle: titleTextField.text! , diaryContent: contentTextView.text!, diaryDate: Date(), diaryRegisterDate: Date())
        
        if let image = mainImageView.image {
            try! localRealm.write {
                localRealm.add(task)
                saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: image)
            }
        } else {
            try! localRealm.write {
                localRealm.add(task)
                saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: UIImage(systemName: "photo")!)
            }
        }
        
//        try! localRealm.write {
//            localRealm.add(task)
//            saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: mainImageView.image!)
//        }
        
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        
        // 1. 이미지를 저장할 경로 설정하기: 도큐먼트 폴더, FilManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        // Desktop/jack/ios/folder/100.png 이런식
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 된 경우, 덮어쓰기가 된다
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제 에러")
            }
        }
        
        // 5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지 저장 에러")
        }
        
        
    }
    
    @IBAction func selectPhotoButtonClicked(_ sender: UIButton) {
        
        // 1. UIAlertController 생성 : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "사진 선택", message: "메세지", preferredStyle: .actionSheet)
    
        let camera = UIAlertAction(title: "사진 찍기", style: .default){ action in
        
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
           
        }
        let album = UIAlertAction(title: "앨범에서 가져오기", style: .default) { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        // 3. 1과 2를 합쳐준다
        // addAction의 순서대로 버튼이 붙는다
        alert.addAction(camera)
        alert.addAction(album)
        
        // 4. Present (보여줌) - modal처럼
        present(alert, animated: true, completion: nil)
    }
    
}

extension ContentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
     
        // 1. 선택한 사진을 가져오기
        // aalowEditing -> editedImage
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // original vs edited Image
            
            // 2. 로직: 이미지뷰에 선택한 사진 보여주기
            mainImageView.image = value
            
        }
        
        // 3. picker dismiss
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     
        print(#function)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
