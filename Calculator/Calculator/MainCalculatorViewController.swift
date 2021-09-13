//
//  MainCalculatorViewController.swift
//  Calculator
//
//  Created by 윤병일 on 2021/09/13.
//

import UIKit
import SnapKit

class MainCalculatorViewController : UIViewController {
  
  //MARK: - Properties
  
  private let numberLabel : UILabel = {
    let label = UILabel()
    label.text = "123"
    label.textColor = .black
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 30)
    label.backgroundColor = .yellow
    return label
  }()
  
   lazy var keypadView : UIView = {
    let v = UIView()
    v.backgroundColor = .green
    return v
  }()
  
  let button1 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button2 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button3 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button4 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button5 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button6 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button7 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button8 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button9 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button10 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button11 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button12 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  let button13 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button14 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button15 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button16 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button17 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  
  let button18 : UIButton = {
    let bt = UIButton()
    return bt
  }()
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    [numberLabel, keypadView].forEach {
      view.addSubview($0)
    }
    
    numberLabel.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(150)
    }
    
    keypadView.snp.makeConstraints { make in
      make.top.equalTo(numberLabel.snp.bottom).offset(24)
      make.leading.trailing.equalTo(numberLabel)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
    }
    
    
    let firstHorizontalStack = UIStackView(arrangedSubviews: [button1, button2])
    firstHorizontalStack.axis = .horizontal
    firstHorizontalStack.distribution = .fillProportionally
    button2.snp.makeConstraints {
      $0.width.equalTo(button1.snp.width).dividedBy(2)
    }
    firstHorizontalStack.spacing = 5
    
    let secondHorizontalStack = UIStackView(arrangedSubviews: [button3, button4, button5, button6])
    secondHorizontalStack.axis = .horizontal
    secondHorizontalStack.distribution = .fillEqually
    secondHorizontalStack.spacing = 5
    
    let thirdHorizontalStack = UIStackView(arrangedSubviews: [button7, button8, button9, button10])
    thirdHorizontalStack.axis = .horizontal
    thirdHorizontalStack.distribution = .fillEqually
    thirdHorizontalStack.spacing = 5
    
    
    let fourthHorizontalStack = UIStackView(arrangedSubviews: [button11, button12, button13, button14])
    fourthHorizontalStack.axis = .horizontal
    fourthHorizontalStack.distribution = .fillEqually
    fourthHorizontalStack.spacing = 5
    
    
    let fifthHorizontalStack = UIStackView(arrangedSubviews: [button15, button16, button17, button18])
    fifthHorizontalStack.axis = .horizontal
    fifthHorizontalStack.distribution = .fillEqually
    fifthHorizontalStack.spacing = 5
    
    
    let verticalStackView = UIStackView(arrangedSubviews: [firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack, fourthHorizontalStack, fifthHorizontalStack])
    verticalStackView.axis = .vertical
    verticalStackView.spacing = 8
    verticalStackView.distribution = .fillEqually
    verticalStackView.alignment = .fill
    
    keypadView.addSubview(verticalStackView)
    verticalStackView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
