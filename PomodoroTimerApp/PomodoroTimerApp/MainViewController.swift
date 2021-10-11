//
//  MainViewController.swift
//  PomodoroTimerApp
//
//  Created by 윤병일 on 2021/10/12.
//

import UIKit
import SnapKit

enum TimerStatus {
  case start
  case pause
  case end
}

class MainViewController : UIViewController {
  
  //MARK: - Properties
  
  let pomodoroImageView : UIImageView = {
    let v = UIImageView()
    v.image = UIImage(named: "pomodoro")
    return v
  }()
  
  let timerLabel : UILabel = {
    let lb = UILabel()
    lb.text = "00:00:00"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 50, weight: .bold)
    lb.textAlignment = .center
    lb.isHidden = true
    return lb
  }()
  
  let progressView : UIProgressView = {
    let v = UIProgressView()
    v.progress = 1
    v.isHidden = true
    return v
  }()
  
  let datePicker : UIDatePicker = {
    let v = UIDatePicker()
    v.preferredDatePickerStyle = .wheels
    v.datePickerMode = .countDownTimer
    v.locale = Locale(identifier: "ko_KR")
    return v
  }()
  
  let cancelButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("취소", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.isEnabled = false
    bt.addTarget(self, action: #selector(tapCancelButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  let startButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("시작", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  var duration = 60 // 타이머에 설정된 시간을 초로 저장하는 프로퍼티, 60 으로 설정하는 이유는 앱이 켜질때 기본적으로 datePicker 가 1분으로 설정되어있기 때문
  var timerStatus : TimerStatus = .end // 타이머의 상태를 가지고있는 프로퍼티, end 로 초기화
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.configureStartButton()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    let buttonStack = UIStackView(arrangedSubviews: [cancelButton, startButton])
    buttonStack.axis = .horizontal
    buttonStack.spacing = 80
    buttonStack.distribution = .fillEqually
    
    [pomodoroImageView, timerLabel, progressView, datePicker, buttonStack ].forEach {
      view.addSubview($0)
    }
    
    pomodoroImageView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
    }
    
    timerLabel.snp.makeConstraints {
      $0.top.equalTo(pomodoroImageView.snp.bottom).offset(80)
      $0.centerX.equalToSuperview()
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
    
    progressView.snp.makeConstraints {
      $0.top.equalTo(timerLabel.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(40)
      $0.trailing.equalToSuperview().offset(-40)
    }
    
    datePicker.snp.makeConstraints {
      $0.top.equalTo(progressView.snp.bottom).offset(30)
      $0.leading.trailing.equalToSuperview()
    }
    
    buttonStack.snp.makeConstraints {
      $0.top.equalTo(datePicker.snp.bottom).offset(24)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
  }
  
  func setTimerInfoViewVisible(isHidden : Bool) {
    self.timerLabel.isHidden = isHidden
    self.progressView.isHidden = isHidden
  }
  
  func configureStartButton() {
    self.startButton.setTitle("시작", for: .normal)
    self.startButton.setTitle("일시정지", for: .selected)
  }
  
  //MARK: - @objc func
  @objc func tapCancelButton(_ sender : UIButton) {
    switch self.timerStatus {
    case .start, .pause :
      self.timerStatus = .end
      self.cancelButton.isEnabled = false
      self.setTimerInfoViewVisible(isHidden: true)
      self.datePicker.isHidden = false
      self.startButton.isSelected = false
      
    default :
      break
    }
  }
  
  @objc func tapStartButton(_ sender : UIButton) {
    self.duration = Int(self.datePicker.countDownDuration) // 초로 계산되서 Int 형으로 변환
    switch self.timerStatus {
    case .end : // 시작 버튼 누를때
      self.timerStatus = .start
      self.setTimerInfoViewVisible(isHidden: false)
      self.datePicker.isHidden = true
      self.startButton.isSelected = true // 시작 버튼 타이틀이 일시정지로 변환한다.
      self.cancelButton.isEnabled = true
    case .start :
      self.timerStatus = .pause
      self.startButton.isSelected = false // 일시정지일때 다시 시작 버튼 타이틀로 돌아오게끔
    case .pause :
      self.timerStatus = .start
      self.startButton.isSelected = true
    }
  }
}
