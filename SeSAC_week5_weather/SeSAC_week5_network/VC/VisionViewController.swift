//
//  VisionViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/27.
//

import UIKit
import JGProgressHUD

/*
 카메라 : 시뮬레이터에서는 테스트가 불가능 -> 런타임 오류가 발생(내 문제가 아님 ㅎ)
 - ImagePickerViewController가 카메라, 갤러리에 대한 처리를 해준다.
 -> PHPickerViewController(iOS14+)가 이런 기능을 새로 담당한다
 - iOS14+ : 선택 접근 권한이 새로 추가되었다, UI개편
 
 */

class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    // 언제 show, hide를 할지 결정해줘야한다
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    var resultAge: Double = 0.0 {
        didSet{
            resultLabel.text = "\(resultAge)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        

    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        progress.show(in: view, animated: true)
        
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            
            print(json)
            
            self.resultAge = json["result"]["faces"][0]["facial_attributes"]["age"].doubleValue
            
            self.progress.dismiss(animated: true)
        }
        
    }
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
       
    }
    
}

extension VisionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // 사진을 촬영하거나 갤러리에서 사진을 선택한 직후에 실행 (필수)
    // imagePickerController는 이미지에 대해 읽는것은 가능하게 되어있다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
     
        // 1. 선택한 사진을 가져오기
        // aalowEditing -> editedImage
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // original vs edited Image
            
            // 2. 로직: 이미지뷰에 선택한 사진 보여주기
            postImageView.image = value
            
        }
        
        // 3. picker dismiss
        picker.dismiss(animated: true, completion: nil)
        
    }

    // (옵션) 취소했을때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
    
}
