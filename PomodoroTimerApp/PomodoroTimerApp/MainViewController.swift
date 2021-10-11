//
//  MainViewController.swift
//  PomodoroTimerApp
//
//  Created by 윤병일 on 2021/10/12.
//

import UIKit
import SnapKit

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
    return bt
  }()
  
  let startButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("시작", for: .normal)
    bt.setTitleColor(.black, for: .normal)
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
  
  //MARK: - @objc func
  
}
