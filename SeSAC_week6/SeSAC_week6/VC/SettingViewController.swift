//
//  SettingViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit
import Zip
import MobileCoreServices

/*
 백업하기
 - 사용자의 저장 공간을 확인
    - 부족 -> 백업불가
 - 백업 진행
    - 어떤 데이터도 없다면 백업할 데이터가 없다고 안내
    - 백업이 가능한 파일 여부 확인. realm, folder의 존재여부 확인
    - 백그라운드 기능이 가능하다면..ㅎ 구현
    - Progress + UI -> 인터렉션을 금지
 - zip파일로 저장
    - 백업이 완료된 시점에
    - Progress + UI -> 인터렉션을 금지
 - 공유 화면
        

 */

/*
 복구하기
 - 사용자의 저장 공간 확인
 - 파일 앱
    - zip 파일인지
    - zip 파일 선택
 - zip -> unzip
    - 백업 파일의 이름 확인
    - 압축해제
        - 백업 파일 확인하기 : 폴더나 파일 이름을 확인
        - 정상적인 파일인가
 - 백업 당시 데이터와 지금 현재 앱에서 사용중인 데이터를 어떻게 합칠건가 고려하기
    - 백업 데이터 선택
 
 */



class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("settingTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        // 4. 백업할 파일에 대한 URL 배열 (하나만 백업할게 아니라 이미지 등을 백업)
        var urlPaths = [URL]()
    
        // 1. 도큐먼트 폴더 위치
        if let path = documentDirectoryPath() {
            
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
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축 경로 : ", zipFilePath)
            presentActivityViewController()
        }
        catch {
          print("Something went wrong")
        }
        
    }
    
    
    @IBAction func onPresentButtonClicked(_ sender: UIButton) {
        
        presentActivityViewController()
    }
    
    @IBAction func onRestoreButtonClicked(_ sender: UIButton) {
        
        // 복구 1. 파일앱 열기 + 확장자
        // import MobileCoreServices 도 하기
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // 여러가지 선택 가능성
        
        self.present(documentPicker, animated: true, completion: nil)
        
        
    }
    
    
    // 도큐먼트의 폴더 위치 가져오기
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
        
    }
    
    // 7. 공유하기
    func presentActivityViewController() {
        
        // 압축파일의 경로 가지고 오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        
        self.present(vc, animated: true, completion: nil)
    
    }
    
}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
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
