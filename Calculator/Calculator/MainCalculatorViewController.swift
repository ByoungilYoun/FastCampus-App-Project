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
    label.text = "0"
    label.textColor = .white
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 40)
    return label
  }()
  
   lazy var keypadView : UIView = {
    let v = UIView()
    v.backgroundColor = .black
    return v
  }()
  
  let acButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("AC", for: .normal)
    bt.backgroundColor = UIColor.init(red: 165 / 255, green: 165 / 255, blue: 165 / 255, alpha: 1)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  let divideButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("/", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  let sevenButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("7", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let eightButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("8", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let nineButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("9", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let multiplyButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("X", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  let fourButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("4", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let fiveButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("5", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let sixButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("6", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let minusButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("ㅡ", for: .normal)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    bt.setTitleColor(.white, for: .normal)
    return bt
  }()
  
  let oneButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("1", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let twoButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("2", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let threeButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("3", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let plusButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("+", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  let zeroButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("0", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  
  let decimalPointButton : UIButton = {
    let bt = UIButton()
    bt.setTitle(".", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let equalButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("=", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .black
    
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
    
    [acButton, divideButton, sevenButton, eightButton, nineButton, multiplyButton, fourButton, fiveButton, sixButton, minusButton, oneButton, twoButton, threeButton, plusButton, zeroButton, decimalPointButton, equalButton].forEach {
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    }
    
    
    let firstHorizontalStack = UIStackView(arrangedSubviews: [acButton, divideButton])
    firstHorizontalStack.axis = .horizontal
    firstHorizontalStack.distribution = .fillProportionally
    divideButton.snp.makeConstraints {
      $0.width.equalTo(acButton.snp.width).dividedBy(3)
    }
    firstHorizontalStack.spacing = 5
    
    let secondHorizontalStack = UIStackView(arrangedSubviews: [sevenButton, eightButton, nineButton, multiplyButton])
    secondHorizontalStack.axis = .horizontal
    secondHorizontalStack.distribution = .fillEqually
    secondHorizontalStack.spacing = 5
    
    let thirdHorizontalStack = UIStackView(arrangedSubviews: [fourButton, fiveButton, sixButton, minusButton])
    thirdHorizontalStack.axis = .horizontal
    thirdHorizontalStack.distribution = .fillEqually
    thirdHorizontalStack.spacing = 5
    
    
    let fourthHorizontalStack = UIStackView(arrangedSubviews: [oneButton, twoButton, threeButton, plusButton])
    fourthHorizontalStack.axis = .horizontal
    fourthHorizontalStack.distribution = .fillEqually
    fourthHorizontalStack.spacing = 5
    
    
    let fifthHorizontalStack = UIStackView(arrangedSubviews: [zeroButton, decimalPointButton, equalButton])
    fifthHorizontalStack.axis = .horizontal
    fifthHorizontalStack.distribution = .fillProportionally
    fifthHorizontalStack.spacing = 5
    
    zeroButton.snp.makeConstraints {
      $0.width.equalTo(fifthHorizontalStack.snp.width).dividedBy(2.3)
    }
      
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
