//
//  AlertListViewController.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/28.
//

import UIKit

class AlertListViewController : UIViewController {
  
  //MARK: - Properties
  let alertListTableView = UITableView()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavi()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
  }
  
  private func configureNavi() {
    title = "물마시기"
//    self.navigationController?.navigationBar.backgroundColor = .lightGray //  ios 15 에서 네비게이션 바 백그라운드 색상 변경하는 방법
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.black] // 네비게이션 타이틀 폰트 색변경
    self.navigationController?.navigationBar.tintColor = .black // 바 버튼 색상 변경 방법
    let plusTimeBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBtnTap) )
    self.navigationItem.rightBarButtonItem = plusTimeBarButton
    
  }
  
  //MARK: - @objc func
  @objc func plusBtnTap() {
    
  }
}
