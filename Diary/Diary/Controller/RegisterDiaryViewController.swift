//
//  RegisterDiaryViewController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

class RegisterDiaryViewController : UIViewController {
  
  //MARK: - Properties
  
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
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    let registerButton = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(registerBtnTapped))
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
  
  //MARK: - @objc func
  
  @objc func registerBtnTapped() {
    
  }
}
