//
//  SettingsViewController.swift
//  LEDBoard
//
//  Created by 윤병일 on 2021/09/12.
//

import UIKit

class SettingsViewController : UIViewController {
  
  //MARK: - Properties
  
  let mainLabel : UILabel = {
    let lb = UILabel()
    lb.text = "전광판에 표시할 글자"
    lb.textColor = .black
    return lb
  }()
  
  let mainTextField : UITextField = {
    let tf = UITextField()
    tf.placeholder = "전광판에 표시할 글자"
    tf.layer.borderColor = UIColor.black.cgColor
    tf.textColor = .black
    tf.layer.borderWidth = 1
    return tf
  }()
  
  private let textColorLabel : UILabel = {
    let lb = UILabel()
    lb.text = "텍스트 색상 설정"
    lb.textColor = .black
    return lb
  }()
  
  private let yellowBtn : UIButton = {
    let bt = UIButton()
    bt.backgroundColor = .yellow
    bt.setTitle("노란색", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  private let redBtn : UIButton = {
    let bt = UIButton()
    bt.backgroundColor = .red
    bt.setTitle("자주색", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  private let greenBtn : UIButton = {
    let bt = UIButton()
    bt.backgroundColor = .green
    bt.setTitle("초록색", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  private let backgroundTextColor : UILabel = {
    let lb = UILabel()
    lb.text = "배경 색상 설정"
    lb.textColor = .black
    return lb
  }()
  
  private let blackBtn : UIButton = {
    let bt = UIButton()
    bt.backgroundColor = .black
    bt.setTitle("검정색", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    return bt
  }()
  
  private let blueBtn : UIButton = {
    let bt = UIButton()
    bt.backgroundColor = .blue
    bt.setTitle("파란색", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  private let orangeBtn : UIButton = {
    let bt = UIButton()
    bt.backgroundColor = .orange
    bt.setTitle("주황색", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  private let saveButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("저장", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavi()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    let stack = UIStackView(arrangedSubviews: [mainLabel, mainTextField])
    stack.axis = .vertical
    stack.spacing = 15
    
    view.addSubview(stack)
    stack.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-80)
    }
    
    let buttonStack = UIStackView(arrangedSubviews: [yellowBtn, redBtn, greenBtn])
    buttonStack.axis = .horizontal
    buttonStack.distribution = .fillEqually
    buttonStack.spacing = 10
    
    let subStack = UIStackView(arrangedSubviews: [textColorLabel, buttonStack])
    subStack.axis = .vertical
    subStack.spacing = 20
    
    view.addSubview(subStack)
    subStack.snp.makeConstraints {
      $0.top.equalTo(stack.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(stack)
    }
    
    let backgroundButtonStack = UIStackView(arrangedSubviews: [blackBtn, blueBtn, orangeBtn])
    backgroundButtonStack.axis = .horizontal
    backgroundButtonStack.distribution = .fillEqually
    backgroundButtonStack.spacing = 10
    
    let backgroundStack = UIStackView(arrangedSubviews: [backgroundTextColor, backgroundButtonStack])
    backgroundStack.axis = .vertical
    backgroundStack.spacing = 20
    
    view.addSubview(backgroundStack)
    backgroundStack.snp.makeConstraints {
      $0.top.equalTo(subStack.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(stack)
    }
    
    view.addSubview(saveButton)
    saveButton.snp.makeConstraints {
      $0.top.equalTo(backgroundStack.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func configureNavi() {
    title = "설정"
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
  }
}
