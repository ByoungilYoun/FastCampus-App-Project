//
//  DetailDiaryViewController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

class DetailDiaryViewController : UIViewController {
  
  //MARK: - Properties
  
  let titleLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "제목"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return lb
  }()
  
  let diaryTitleLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "일기제목"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    lb.numberOfLines = 3
    return lb
  }()
  
  let contentLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "내용"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return lb
  }()
  
  let contentTextView : UITextView = {
    let v = UITextView()
    v.textColor = .black
    v.layer.borderColor = UIColor.lightGray.cgColor
    v.isEditable = false
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
  
  let dateDataLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "20.09.03 (토)"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return lb
  }()
  
  let editButton : UIButton = {
    let bt = UIButton()
    bt.titleLabel?.text = "수정"
    bt.titleLabel?.textColor = .black
    bt.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  let removeButton : UIButton = {
    let bt = UIButton()
    bt.titleLabel?.text = "삭제"
    bt.titleLabel?.textColor = .red
    bt.addTarget(self, action: #selector(removeBtnTapped), for: .touchUpInside)
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
    
    let stack = UIStackView(arrangedSubviews: [titleLabel, diaryTitleLabel])
    stack.spacing = 12
    stack.axis = .vertical
    
    titleLabel.snp.makeConstraints {
      $0.height.equalTo(20)
    }
    
    diaryTitleLabel.snp.makeConstraints {
      $0.height.equalTo(20)
    }
    
    let secondStack = UIStackView(arrangedSubviews: [dateLabel, dateDataLabel])
    stack.axis = .vertical
    stack.spacing = 12
    
    let buttonStack = UIStackView(arrangedSubviews: [editButton, removeButton])
    stack.spacing = 50
    stack.axis = .horizontal
    stack.alignment = .center
    
    [stack, contentLabel, contentTextView, secondStack, buttonStack].forEach {
      view.addSubview($0)
    }
    
    stack.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
    
    contentLabel.snp.makeConstraints {
      $0.top.equalTo(stack.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(stack)
    }
    
    contentTextView.snp.makeConstraints {
      $0.top.equalTo(contentLabel.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(stack)
      $0.height.equalTo(150)
    }
    
    secondStack.snp.makeConstraints {
      $0.top.equalTo(contentTextView.snp.bottom).offset(24)
      $0.leading.trailing.equalTo(stack)
    }
    
    buttonStack.snp.makeConstraints {
      $0.top.equalTo(secondStack.snp.bottom).offset(24)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalTo(stack)
    }
  }
  
  //MARK: - @objc func
  @objc func editBtnTapped() {
    
  }
  
  @objc func removeBtnTapped() {
    
  }
}
