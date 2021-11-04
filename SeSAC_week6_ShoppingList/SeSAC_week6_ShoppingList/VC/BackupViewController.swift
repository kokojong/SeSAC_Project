//
//  BackupViewController.swift
//  SeSAC_week6_ShoppingList
//
//  Created by kokojong on 2021/11/04.
//

import UIKit
import Zip
import MobileCoreServices
import MBProgressHUD

class BackupViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func onBackupButtonClicked(_ sender: UIButton) {
        
        // 4. urlpath의 배열
        var urlPaths = [URL]()
        
        // 1. 도큐먼트 폴더 위치
        if let path = getDocumentDirectoryPath() {
            
            // 2. 백업하고자 하는 파일 url 확인
            // 이미지 같은 경우에는 백업 편의성을 위해 폴더를 만들어서 정리해주는것이 편함
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            // 3. 백업하고자 하는 파일의 존재여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. URL 배열에 백업 파일 URL을 추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다")
            }
        }
        
        // 6. 4번 배열에 대해서 압축파일을 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip 경로
            print("압축 경로 : ", zipFilePath)
            presentActivityViewController()
        }
        catch {
          print("Something went wrong")
        
        }
        
    }
    
    @IBAction func onRestoreButtonClicked(_ sender: UIButton) {
        
        // 1. UIAlertController 생성 : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "데이터 복구", message: "데이터 복구가 완료되면 앱이 종료됩니다.", preferredStyle: .alert)
        // 2. UIAlertAction 생성 : 버튼들을 만들어준다
        let ok = UIAlertAction(title: "확인", style: .default){ _ in
            
            // 복구 1. 파일앱 열기 + 확장자
            // import MobileCoreServices 도 하기
            let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false // 여러가지 선택 가능성
            
            let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            Indicator.label.text = "데이터 복구"
            Indicator.isUserInteractionEnabled = false
            Indicator.detailsLabel.text = "데이터 복구중입니다 잠시만 기다려주세요"

            // 4. Present (보여줌) - modal처럼
            self.present(documentPicker, animated: true, completion: nil)
            
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        

    }

    
    // 도큐먼트의 폴더 위치 가져오기
    func getDocumentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        print(path)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
        
    }
    
    // 7. UIActivityViewController 보여주기
    func presentActivityViewController() {
        
        // 압축파일의 경로 가지고 오기
        let fileName = (getDocumentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        
        self.present(vc, animated: true, completion: nil)
    
    }
    
    
}

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        // 복구 2. 선택한 파일에 대한 경로를 가져와야 함
        // ex. iphone/jack/fileapp/archive.zip
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            // 기존에 복구하고자 하는 zip파일을 도큐먼트에 가지고 있는 경우에, 도큐먼트에 위치한 zip을 압축 해제 하면 된다
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress : ", progress)
                    
                    
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : ",unzippedFile)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    exit(0) // 앱 종료
                    
                    
                })
                
                
            } catch {
                print("error")
            }
            
            
        } else {
            // 파일 앱의 zip -> 도큐먼트 폴더에 복사
            do {
                
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress : ", progress)
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : ",unzippedFile)
                })
                
            } catch {
                print("error")
            }
            
            
            
        }
        
        
        
    }
    
    
}
