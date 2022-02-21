//
//  TabBarController.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import UIKit

class TabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let translateViewController = TranslateViewController()
    translateViewController.tabBarItem = UITabBarItem(title: "번역", image: UIImage(systemName: "mic"), selectedImage: UIImage(systemName: "mic.fill"))
    
    let bookmarkViewController = UINavigationController(rootViewController: BookmarkListViewController())
    bookmarkViewController.tabBarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
    
    self.viewControllers = [translateViewController, bookmarkViewController]
  }


}

