//
//  MainViewController.swift
//  LEDBoard
//
//  Created by 윤병일 on 2021/09/12.
//

import UIKit
import SnapKit

class MainViewController :  UIViewController {
  
  //MARK: - Properties
  
  private let mainLabel : UILabel = {
    let label = UILabel()
    label.text = "윤병일"
    label.textColor = .yellow
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 50)
    return label
  }()
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavi()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .black
    
    view.addSubview(mainLabel)
    mainLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
  }
  
  private func configureNavi() {
    navigationController?.navigationBar.barTintColor = .white
    let rightBarButton = UIBarButtonItem(title: "설정", style: .done, target: self, action: #selector(buttonTap))
    rightBarButton.tintColor = .systemBlue
    navigationItem.rightBarButtonItem = rightBarButton
  }
  
  //MARK: - @objc func
   @objc private func buttonTap() {
    print("123")
  }
}
