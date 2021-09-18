//
//  AppDelegate.swift
//  SpotifyLoginPage
//
//  Created by 윤병일 on 2021/09/15.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Firebase 초기화
    FirebaseApp.configure()
    
    // Google
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    
    return true
  }
  
  // 구글의 인증 프로세스가 끝날때 앱이 수신하는 url 을 처리하는 역할을 하게 된다.
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }
  
  // 우리의 로그인 화면에서 구글에서 제공한 url 로 인증을 한후 전달된 구글 로그인값을 처리 하는 부분, 특별한 에러가 없다면 credential, 즉 구글 아이디 토큰을 부여받는다.
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if let error = error {
      print("Error Google SignIn : \(error.localizedDescription)")
      return
    }
    
    guard let authentication = user.authentication else {return}
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    
    Auth.auth().signIn(with: credential) { _, _ in
      self.showMainViewController()
    }
  }
  
  private func showMainViewController () {
    let vc = MainViewController()
    UIApplication.shared.windows.first?.rootViewController?.show(vc, sender: nil)
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

