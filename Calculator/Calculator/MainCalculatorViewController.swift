//
//  MainCalculatorViewController.swift
//  Calculator
//
//  Created by 윤병일 on 2021/09/13.
//

import UIKit
import SnapKit

enum Operation {
  case Add
  case Subtract
  case Divide
  case Multiply
  case unknown
}

class MainCalculatorViewController : UIViewController {
  
  //MARK: - Properties
  
  var disPlayNumber = "" // 보여지는 숫자 저장하는 프로퍼티
  var firstOperand = "" //이전 계산 값을 저장하는 프로퍼티
  var secondOperand = "" //새롭게 입력되는 값을 저장하는 프로퍼티
  var result = "" //계산의 결과값을 저장하는 프로퍼티
  var currentOperation : Operation = .unknown //현재 계산기에 어떤 연산자가 입력되었는지 알 수 있게 연산자를 저장하는 변수
  
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
    bt.addTarget(self, action: #selector(tapClearButton), for: .touchUpInside)
    return bt
  }()
  
  let divideButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("/", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapDivideButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  let sevenButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("7", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  let eightButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("8", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let nineButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("9", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let multiplyButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("X", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapMultiplyButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  let fourButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("4", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let fiveButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("5", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let sixButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("6", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let minusButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("ㅡ", for: .normal)
    bt.addTarget(self, action: #selector(tapMinusButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    bt.setTitleColor(.white, for: .normal)
    return bt
  }()
  
  let oneButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("1", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let twoButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("2", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let threeButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("3", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let plusButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("+", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapPlusButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    return bt
  }()
  
  let zeroButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("0", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  
  let decimalPointButton : UIButton = {
    let bt = UIButton()
    bt.setTitle(".", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(tapDotButton(_:)), for: .touchUpInside)
    bt.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    return bt
  }()
  
  let equalButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("=", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = UIColor.init(red: 254 / 255, green: 160 / 255, blue: 10 / 255, alpha: 1)
    bt.addTarget(self, action: #selector(tapEqualButton(_:)), for: .touchUpInside)
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
  
  func operation(_ operation : Operation) {
    if self.currentOperation != .unknown {
      if !self.disPlayNumber.isEmpty {
        self.secondOperand = self.disPlayNumber
        self.disPlayNumber = ""
        
        // 계산을 위해 스트링에서 더블형으로 바꿔준다.
        guard let firstOperand = Double(self.firstOperand)  else { return }
        guard let secondOperand = Double(self.secondOperand) else { return }
        
        switch self.currentOperation {
        case .Add :
          self.result = "\(firstOperand + secondOperand)"
        case .Subtract :
          self.result = "\(firstOperand - secondOperand)"
        case .Divide :
          self.result = "\(firstOperand / secondOperand)"
        case .Multiply :
          self.result = "\(firstOperand * secondOperand)"
        default :
          break
        }
        
        // 1로 나눈 나머지가 0일때는 Double 형인 result 를 Int 형으로 바꿔준다.
        if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
          self.result = "\(Int(result))"
        }
        
        self.firstOperand = self.result
        self.numberLabel.text = self.result
      }
      
      self.currentOperation = operation
    } else {
      self.firstOperand = self.disPlayNumber
      self.currentOperation = operation
      self.disPlayNumber = ""
    }
  }
  
  //MARK: - @objc func
  @objc func tapNumberButton(_ sender : UIButton) {
    guard let numberValue = sender.title(for: .normal) else {return}
    
    if self.disPlayNumber.count < 9 {
      self.disPlayNumber += numberValue
      self.numberLabel.text = self.disPlayNumber
    }
  }
  
  @objc func tapClearButton(_ sender : UIButton) {
    //모든 프로퍼티 초기값으로 초기화
    //numberLabel 에 0으로
    self.disPlayNumber = ""
    self.firstOperand = ""
    self.secondOperand = ""
    self.result = ""
    self.currentOperation = .unknown
    self.numberLabel.text = "0"
  }
  
  @objc func tapDotButton(_ sender : UIButton) {
    if self.disPlayNumber.count < 8, !self.disPlayNumber.contains(".") { //0.소수점하면 8자리까지만 해야 총 9자리 까지니까 예외처리를 8보다 작을때로 해준다
      self.disPlayNumber += self.disPlayNumber.isEmpty ? "0." : "."
      self.numberLabel.text = self.disPlayNumber
    }
  }
  
  @objc func tapDivideButton(_ sender : UIButton) {
    self.operation(.Divide)
  }
  
  @objc func tapMultiplyButton(_ sender : UIButton) {
    self.operation(.Multiply)
  }
  
  @objc func tapMinusButton(_ sender : UIButton) {
    self.operation(.Subtract)
  }
  
  @objc func tapPlusButton(_ sender : UIButton) {
    self.operation(.Add)
  }
  
  @objc func tapEqualButton(_ sender : UIButton) {
    self.operation(self.currentOperation)
  }
}
