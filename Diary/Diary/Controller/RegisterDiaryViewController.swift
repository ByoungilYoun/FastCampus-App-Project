//
//  RegisterDiaryViewController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

enum DiaryEditorMode {
  case new
  case edit(IndexPath, Diary)
}

protocol RegisterDiaryViewControllerDelegate : AnyObject {
  func didSelectRegister(diary : Diary)
}

class RegisterDiaryViewController : UIViewController {
  
  //MARK: - Properties
  
  weak var delegate : RegisterDiaryViewControllerDelegate?
  
  let titleLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "제목"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    lb.numberOfLines = 0
    return lb
  }()
  
  let titleTextField : UITextField = {
    let tf = UITextField()
    tf.textColor = .black
    tf.layer.borderColor = UIColor.lightGray.cgColor
    tf.layer.borderWidth = 0.5
    return tf
  }()

  let contentLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "내용"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    lb.numberOfLines = 0
    return lb
  }()
  
  let contentTextView : UITextView = {
    let v = UITextView()
    v.textColor = .black
    v.layer.borderColor = UIColor.lightGray.cgColor
    v.layer.borderWidth = 0.5
    return v
  }()
  
  let dateLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "날짜"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return lb
  }()
  
  let dateTextField : UITextField = {
    let tf = UITextField()
    tf.textColor = .black
    tf.layer.borderColor = UIColor.lightGray.cgColor
    tf.layer.borderWidth = 0.5
    return tf
  }()
  
  var registerButton = UIBarButtonItem()
  
  private let datePicker = UIDatePicker()
  private var diaryDate : Date?
  
  var diaryEditorMode : DiaryEditorMode = .new
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureDatePicker()
    configureInputField()
    configureEditMode()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    registerButton = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(registerBtnTapped))
    registerButton.isEnabled = false
    navigationItem.rightBarButtonItem = registerButton
    
    [titleLabel, titleTextField, contentLabel, contentTextView, dateLabel, dateTextField].forEach {
      view.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
    
    titleTextField.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(titleLabel)
      $0.height.equalTo(30)
    }
    
    contentLabel.snp.makeConstraints {
      $0.top.equalTo(titleTextField.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(titleLabel)
    }
    
    contentTextView.snp.makeConstraints {
      $0.top.equalTo(contentLabel.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(titleLabel)
      $0.height.equalTo(100)
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalTo(contentTextView.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(titleLabel)
    }
    
    dateTextField.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(titleLabel)
      $0.height.equalTo(30)
    }
  }
  
  private func configureDatePicker() {
    self.datePicker.datePickerMode = .date
    self.datePicker.preferredDatePickerStyle = .wheels
    self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
    self.datePicker.locale = Locale(identifier: "ko_KR")
    self.dateTextField.inputView = self.datePicker
  }
  
  private func configureInputField() {
    self.contentTextView.delegate = self
    self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
  }
  
  private func validateInputField() {
    self.registerButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentTextView.text.isEmpty
  }
  
  private func configureEditMode() {
    switch self.diaryEditorMode {
    case let .edit(_, diary) :
      self.titleTextField.text = diary.title
      self.contentTextView.text = diary.contents
      self.dateTextField.text = self.dateToString(date: diary.date)
      self.diaryDate = diary.date
      self.registerButton.title = "수정"
      
    default :
      break
    }
  }
  
  private func dateToString(date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
  }
  
  //MARK: - @objc func
  
  @objc func registerBtnTapped() {
    guard let title = self.titleTextField.text else {return}
    guard let contents = self.contentTextView.text else {return}
    guard let date = self.diaryDate else {return}
    
    let diary = Diary(title: title, contents: contents, date: date, isStar: false)
    
    switch self.diaryEditorMode {
    case .new :
      self.delegate?.didSelectRegister(diary: diary)
    case let .edit(indexPath, _) :
      NotificationCenter.default.post(name: NSNotification.Name("editDiary"),
                                      object: diary,
                                      userInfo: ["indexPath.row" : indexPath.row])
      
    }
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc private func datePickerValueDidChange(_ datePicker : UIDatePicker) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일 (EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    self.diaryDate = datePicker.date
    self.dateTextField.text = formatter.string(from: datePicker.date)
    self.dateTextField.sendActions(for: .editingChanged) // 날짜가 변경될때마다 editingChanged 액션이 발생되서 dateTextFieldDidChange 가 호출된다.
  }
  
  @objc private func titleTextFieldDidChange(_ textField : UITextField) {
    self.validateInputField()
  }
  
  @objc private func dateTextFieldDidChange(_ textField : UITextField) {
    self.validateInputField()
  }
}

  //MARK: - RegisterDiaryViewController
extension RegisterDiaryViewController : UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) { // 텍스트 뷰에 텍스트가 입력될때마다 호출됨
    self.validateInputField()
  }
}
