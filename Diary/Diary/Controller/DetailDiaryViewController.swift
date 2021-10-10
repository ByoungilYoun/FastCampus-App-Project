//
//  DetailDiaryViewController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

protocol DetailDiaryViewControllerDelegate : AnyObject {
  func didSelectDelete(indexPath : IndexPath)
}

class DetailDiaryViewController : UIViewController {
  
  //MARK: - Properties
  
  weak var delegate : DetailDiaryViewControllerDelegate?
  
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
    bt.setTitle("수정", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  let removeButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("삭제", for: .normal)
    bt.setTitleColor(.red, for: .normal)
    bt.addTarget(self, action: #selector(removeBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  var diary : Diary?
  var indexPath : IndexPath?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    guard let diary = self.diary else {return}
    self.diaryTitleLabel.text = diary.title
    self.contentTextView.text = diary.contents
    self.dateDataLabel.text = self.dateToString(date: diary.date)
    
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
    
    dateLabel.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.width.equalTo(40)
    }
    
    dateDataLabel.snp.makeConstraints {
      $0.height.equalTo(20)
    }

    
    [stack, contentLabel, contentTextView, secondStack, editButton, removeButton].forEach {
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
    
    editButton.snp.makeConstraints {
      $0.top.equalTo(secondStack.snp.bottom).offset(20)
      $0.centerX.equalToSuperview().offset(-30)
      $0.width.equalTo(50)
      $0.height.equalTo(30)
    }
    
    removeButton.snp.makeConstraints {
      $0.top.equalTo(editButton)
      $0.centerX.equalToSuperview().offset(30)
      $0.width.height.equalTo(editButton)
    }
  }
  
  private func dateToString(date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
  }
  
  //MARK: - @objc func
  @objc func editBtnTapped() {
    print("edit button tapped")
  }
  
  @objc func removeBtnTapped() {
    guard let indexPath = self.indexPath else {
      return
    }

    self.delegate?.didSelectDelete(indexPath: indexPath)
    self.navigationController?.popViewController(animated: true)
  }
}
