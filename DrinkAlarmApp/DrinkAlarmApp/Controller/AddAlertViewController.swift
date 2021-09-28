//
//  AddAlertViewController.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/28.
//

import UIKit

class AddAlertViewController : UIViewController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    configureUI()
    configureNavi()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
   
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
  }
  
  private func configureNavi() {
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(moveBack))
    backButton.tintColor = .black
    navigationItem.leftBarButtonItem = backButton
  }
  
  //MARK: - @objc func
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
}

extension AddAlertViewController : UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
