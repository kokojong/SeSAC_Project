//
//  AppDelegate.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/13.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(#function)
        FirebaseApp.configure()
        
        // 알림 등록(권한)
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        // 메세지 대리자 설정 (Firebase에게 위임)
        Messaging.messaging().delegate = self
        
        // 현재 등록 토큰 가져오기
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
        
        

        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print(#function)
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print(#function)
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // apn 토큰과 등록 토큰 매핑
    
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(application: UIApplication,
                didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    // 포그라운드 수신
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
        
        // 사용자가 이미 이 화면이라면 푸쉬가 안뜨게 하고 다른 화면이면 푸쉬가 뜨게함(카톡을 이미 하고 있는 사람한테 톡이오면 알림x)
        if rootViewController is DetailViewController {
            completionHandler([])
        } else {
            completionHandler([.list, .banner, .badge, .sound])
        }
        
        
//        completionHandler([.list, .banner, .badge, .sound]) // .alert -> .list, .banner
        
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("푸 쉬 클 릭")
        // userInfo: key - 1(광고) 2(채팅방으로 넘어가게) 3(사용자 설정으로 가는)
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.body)
        
        let userInfo = response.notification.request.content.userInfo
        if userInfo[AnyHashable("key")] as? String == "1" {
            print("광고 푸쉬")
        } else {
            print("다른 푸쉬")
        }
        
        // Scene Delegate의 window 객체 가져오기
        // 최상단 뷰
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print("rootViewController : ",rootViewController) // tapBarController가 프린트 -> 실제로 여기서는 뭘 하기가 애매하다
        
//        if rootViewController is SnapDetailViewController {
//            rootViewController.present(DetailViewController(), animated: true, completion: nil)
//        }
//
        if rootViewController is DetailViewController {
//            let nav = UINavigationController(rootViewController: SnapDetailViewController())
//            nav.modalPresentationStyle = .fullScreen
//            rootViewController.navigationController?.present(nav, animated: true, completion: nil)
            
            rootViewController.navigationController?.pushViewController(SnapDetailViewController(), animated: true)
        
//            rootViewController.dismiss(animated: true, completion: nil)
        }
        
        completionHandler()
    }

}

extension AppDelegate: MessagingDelegate {
    
    // 토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    
}

// 최상단 뷰컨트롤러를 판단해주는 extension
extension UIViewController {
    
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationViewController = currentViewController as? UINavigationController,
            let visibleViewController = navigationViewController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
            
        } else if let presentViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentViewController)
            
        } else {
            return currentViewController
        }
    }
}
