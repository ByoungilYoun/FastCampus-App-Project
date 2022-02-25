//
//  SceneDelegate.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    self.window = UIWindow(windowScene: windowScene)
    self.window?.backgroundColor = .systemBackground
    self.window?.rootViewController = UINavigationController(rootViewController: ReviewListViewController())
    self.window?.makeKeyAndVisible()
  }
}

