//
//  AppDelegate.swift
//  NoticePopup
//
//  Created by 윤병일 on 2021/09/24.
//

import UIKit
import Firebase
import FirebaseInstallations

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    
    // 토큰 가져와서 파이어베이스 웹에서 여기서 얻은 토큰을 가지고 직접 A 또는 B 안을 세팅해서 볼 수 있다.
    Installations.installations().authTokenForcingRefresh(true) { result, error in
      if error != nil {
        print("Error")
        return
      }
      
      guard let result = result else {return}
      print("Installation auth token : \(result.authToken)")
      
    }
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

