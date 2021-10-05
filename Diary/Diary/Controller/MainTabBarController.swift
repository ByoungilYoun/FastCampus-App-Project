//
//  MainTabBarController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import Foundation
import UIKit
import SnapKit

class MainTabBarController : UITabBarController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    
    let tabbarAppearance = UITabBarAppearance()
    tabbarAppearance.configureWithOpaqueBackground()
    tabbarAppearance.backgroundColor = .white
    tabBar.standardAppearance = tabbarAppearance
    tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    
    let controller1 = DiaryListViewController()
    controller1.tabBarItem = UITabBarItem(title: "일기장", image: UIImage(systemName: "folder"), tag: 0)
    controller1.tabBarItem.selectedImage = UIImage(systemName: "folder.fill")
    let nav1 = UINavigationController(rootViewController: controller1)
    
    let controller2 = FavoriteViewController()
    controller2.tabBarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "star"), tag: 0)
    controller2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
    let nav2 = UINavigationController(rootViewController: controller2)
    
    viewControllers = [nav1, nav2]
    
  }
  
  //MARK: - @objc func
  
}
