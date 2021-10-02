//
//  AppDelegate.swift
//  Warning
//
//  Created by 윤병일 on 2021/09/30.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    
    Messaging.messaging().delegate = self
    
    // FCM 현재 등록 토큰 확인 하는 코드
    Messaging.messaging().token { token, error in
      if let error = error {
        print("Error FCM 등록 토큰 가져오기 : \(error.localizedDescription)")
      } else if let token = token {
        print("FCM 등록토큰 : \(token)")
      }
    }
    
    let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
    
    UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
      if let error = error {
        print("Error : Request notifications authorization : \(error.localizedDescription)")
        return
      }
    }
    
    application.registerForRemoteNotifications()
    
    return true
  }
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

  //MARK: - UNUserNotificationCenterDelegate
extension AppDelegate : UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.list, .badge, .banner, .sound])
  }
}

extension AppDelegate : MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    guard let token = fcmToken else { return }
    print("FCM 등록토큰 갱신 : \(token)")
  }
}