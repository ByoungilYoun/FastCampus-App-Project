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
  
  var starButton : UIBarButtonItem?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  deinit { // deinit 될때 옵저버 모두 제거
    NotificationCenter.default.removeObserver(self)
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white

    guard let diary = self.diary else {return}
    self.diaryTitleLabel.text = diary.title
    self.contentTextView.text = diary.contents
    self.dateDataLabel.text = self.dateToString(date: diary.date)
    
    self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
    self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    self.starButton?.tintColor = .orange
    self.navigationItem.rightBarButtonItem = self.starButton
    
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
    let vc = RegisterDiaryViewController()
    guard let indexPath = indexPath else {
      return
    }

    guard let diary = diary else {
      return
    }

    vc.diaryEditorMode = .edit(indexPath, diary)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(editDiaryNotification(_:)),
                                           name: NSNotification.Name("editDiary"),
                                           object: nil)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func removeBtnTapped() {
    guard let indexPath = self.indexPath else {
      return
    }

//    self.delegate?.didSelectDelete(indexPath: indexPath)
    NotificationCenter.default.post(name: NSNotification.Name("deleteDiary"),
                                    object: indexPath,
                                    userInfo: nil)
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func editDiaryNotification(_ notification : Notification) {
    guard let diary = notification.object as? Diary else {return} // 포스트 한 다이어리 객체를 notification.object 로 가져올수 있다.
    self.diary = diary
    self.configureUI()
  }
  
  @objc func tapStarButton() {
    guard let isStar = self.diary?.isStar else {return}
    guard let indexPath = self.indexPath else {return}
    
    if isStar {
      self.starButton?.image = UIImage(systemName: "star")
    } else {
      self.starButton?.image = UIImage(systemName: "star.fill")
    }
    
    self.diary?.isStar = !isStar
    NotificationCenter.default.post(name: Notification.Name("starDiary"),
                                    object: [
                                      "diary" : self.diary, //즐겨찾기가 된 다이어리
                                      "isStar" : self.diary?.isStar ?? false,
                                      "indexPath" : indexPath
                                    ], userInfo: nil)
  }
}
