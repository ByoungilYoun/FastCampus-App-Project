//
//  AddAlertViewController.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/28.
//

import UIKit

class AddAlertViewController : UIViewController {
  
  //MARK: - Properties
  
  var pickedDate : ((_ date : Date) -> Void)? // 클로저를 통해서 저장 버튼을 눌렀을때데이트피커 값을 부모뷰로 전달해준다.
  
  private let timeLabel : UILabel = {
    let lb = UILabel()
    lb.text = "시간"
    lb.textColor = .black
    return lb
  }()
  
  let timeSelectDatePicker : UIDatePicker = {
    let pk = UIDatePicker()
    pk.preferredDatePickerStyle = .inline
    pk.datePickerMode = .time
    pk.locale = Locale(identifier: "ko")
    return pk
  }()
  
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
    
    [timeLabel, timeSelectDatePicker].forEach {
      view.addSubview($0)
    }
    
    timeLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
      $0.leading.equalToSuperview().offset(30)
    }
    
    timeSelectDatePicker.snp.makeConstraints {
      $0.width.equalTo(193)
      $0.height.equalTo(50)
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerY.equalTo(timeLabel)
    }
  }
  
  private func configureNavi() {
    title = "알람추가"
    let cancleButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(moveBack))
    let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveTime))
    cancleButton.tintColor = .black
    saveButton.tintColor = .black
    navigationItem.leftBarButtonItem = cancleButton
    navigationItem.rightBarButtonItem = saveButton
  }
  
  //MARK: - @objc func
  @objc func moveBack() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func saveTime() {
    pickedDate?(timeSelectDatePicker.date)
    self.navigationController?.popViewController(animated: true)
  }
}

extension AddAlertViewController : UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
