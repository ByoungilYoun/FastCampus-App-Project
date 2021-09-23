//
//  NoticeViewController.swift
//  NoticePopup
//
//  Created by 윤병일 on 2021/09/24.
//

import UIKit
import SnapKit

class NoticeViewController : UIViewController {
  
  //MARK: - Properties
  
  private let noticeView : UIView = {
    let v = UIView()
    v.backgroundColor = .white
    return v
  }()
  
  private let mainTitle : UILabel = {
    let lb = UILabel()
    lb.text = "공지사항"
    lb.textColor = .black
    lb.textAlignment = .center
    lb.font = UIFont.boldSystemFont(ofSize: 17)
    return lb
  }()
  
  
  let introduceLabel : UILabel = {
    let lb = UILabel()
    lb.text = "안내드립니다"
    lb.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    lb.textColor = .black
    lb.textAlignment = .center
    lb.numberOfLines = 2
    return lb
  }()
  
  let subIntroduceLabel : UILabel = {
    let lb = UILabel()
    lb.text = "서비스 이용에 참고 부탁드립니다"
    lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    lb.textColor = .black
    lb.textAlignment = .center
    lb.numberOfLines = 4
    return lb
  }()
  
  let dueTimeLabel : UILabel = {
    let lb = UILabel()
    lb.text = "점검 일시"
    lb.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    lb.textColor = .black
    lb.textAlignment = .left
    return lb
  }()
  
  let dateLabel : UILabel = {
    let lb = UILabel()
    lb.text = "2021년 1월 31일 00:00 - 03:00"
    lb.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    lb.textColor = .black
    return lb
  }()
  
  let confirmButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("확인", for: .normal)
    bt.backgroundColor = .lightGray
    bt.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  var noticeContents : (title : String, detail : String, date : String)?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let noticeContents = noticeContents else {return}
    introduceLabel.text = noticeContents.title
    subIntroduceLabel.text = noticeContents.detail
    dateLabel.text = noticeContents.date
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    view.addSubview(noticeView)
    noticeView.layer.cornerRadius = 10
    
    noticeView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalTo(300)
      $0.height.equalTo(400)
    }
    
    let stackView = UIStackView(arrangedSubviews: [mainTitle, introduceLabel, subIntroduceLabel, dueTimeLabel,dateLabel, confirmButton])
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    stackView.spacing = 10
    
    noticeView.addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(20)
      $0.trailing.bottom.equalToSuperview().offset(-20)
    }
    
    confirmButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(60)
    }
  }
  
  //MARK: - @objc func
  @objc func confirmBtnTapped() {
    self.dismiss(animated: true, completion: nil)
  }
}
