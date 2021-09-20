//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by 윤병일 on 2021/09/20.
//

import UIKit
import Lottie

class CardDetailViewController : UIViewController {
  
  //MARK: - Properties
  
  var promotionDetail : PromotionDetail?
  
  
  let mainTitleLabel : UILabel = {
    let lb = UILabel()
    lb.text = "신용카드 쓰면\n0만원 드려요"
    lb.textColor = .darkGray
    lb.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
    lb.numberOfLines = 0
    lb.textAlignment = .left
    return lb
  }()
  
  lazy var lottieView : AnimationView = { // AnimationView 는 lottie 에서 제공해주는 뷰 이다.
    let v = AnimationView()
    return v
  }()
  
  private let participationPeriodLabel : UILabel = {
    let lb = UILabel()
    lb.text = "참여 기간"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 17)
    return lb
  }()
  
  let dateLabel : UILabel = {
    let lb = UILabel()
    lb.text = "2021.1.1(월) ~ 2021.1.31(일)"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17)
    return lb
  }()
  
  private let participationConditionLabel : UILabel = {
    let lb = UILabel()
    lb.text = "참여 조건"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 17)
    return lb
  }()
  
  let conditionLabel : UILabel = {
    let lb = UILabel()
    lb.text = "조건 없음"
    lb.textColor = .black
    lb.numberOfLines = 0
    lb.font = UIFont.systemFont(ofSize: 17)
    return lb
  }()
  
  private let benefitConditionLabel : UILabel = {
    let lb = UILabel()
    lb.text = "혜택 조건"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 17)
    return lb
  }()
  
  let benefitConditions : UILabel = {
    let lb = UILabel()
    lb.text = "조건 없음"
    lb.textColor = .black
    lb.numberOfLines = 0
    lb.font = UIFont.systemFont(ofSize: 17)
    return lb
  }()
  
  private let benefitYouGetLabel : UILabel = {
    let lb = UILabel()
    lb.text = "받는 혜택"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 17)
    return lb
  }()
  
  let benefitYouGet : UILabel = {
    let lb = UILabel()
    lb.text = "혜택 없음"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17)
    return lb
  }()
  
  private let dateYouGetLabel : UILabel = {
    let lb = UILabel()
    lb.text = "받는 날짜"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 17)
    return lb
  }()
  
  let dateYouGet : UILabel = {
    let lb = UILabel()
    lb.text = "2021.1.1(월) ~ 2021.1.31(일)"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17)
    return lb
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setLottieAnimaiton()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    title = "카드 혜택 상세"
    
    lottieView.snp.makeConstraints {
      $0.height.equalTo(200)
    }
    
    participationPeriodLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    participationConditionLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    benefitConditionLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    benefitYouGetLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    dateYouGetLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    let firstVerticalStackView = UIStackView(arrangedSubviews: [mainTitleLabel, lottieView])
    firstVerticalStackView.axis = .vertical
    firstVerticalStackView.alignment = .fill
    firstVerticalStackView.distribution = .fill
    firstVerticalStackView.spacing = 20
    
    let secondHoriziontalStackView = UIStackView(arrangedSubviews: [participationPeriodLabel, dateLabel])
    secondHoriziontalStackView.axis = .horizontal
    secondHoriziontalStackView.alignment = .center
    secondHoriziontalStackView.distribution = .fill
    secondHoriziontalStackView.spacing = 30
    
  
    let thirdHorizontalStackView = UIStackView(arrangedSubviews: [participationConditionLabel, conditionLabel])
    thirdHorizontalStackView.axis = .horizontal
    thirdHorizontalStackView.alignment = .center
    thirdHorizontalStackView.distribution = .fill
    thirdHorizontalStackView.spacing = 30
    
    let fourthHorizontalStackView = UIStackView(arrangedSubviews: [benefitConditionLabel, benefitConditions])
    fourthHorizontalStackView.axis = .horizontal
    fourthHorizontalStackView.alignment = .center
    fourthHorizontalStackView.distribution = .fill
    fourthHorizontalStackView.spacing = 30
    
    let fifthHoriziontalStackView = UIStackView(arrangedSubviews: [benefitYouGetLabel, benefitYouGet])
    fifthHoriziontalStackView.axis = .horizontal
    fifthHoriziontalStackView.alignment = .center
    fifthHoriziontalStackView.distribution = .fill
    fifthHoriziontalStackView.spacing = 30
    
    let sixthHoriziontalStackView = UIStackView(arrangedSubviews: [dateYouGetLabel, dateYouGet])
    sixthHoriziontalStackView.axis = .horizontal
    sixthHoriziontalStackView.alignment = .center
    sixthHoriziontalStackView.distribution = .fill
    sixthHoriziontalStackView.spacing = 30
    
    [firstVerticalStackView, secondHoriziontalStackView, thirdHorizontalStackView, fourthHorizontalStackView, fifthHoriziontalStackView, sixthHoriziontalStackView].forEach {
      view.addSubview($0)
    }
    
    firstVerticalStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }

    secondHoriziontalStackView.snp.makeConstraints {
      $0.top.equalTo(firstVerticalStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(firstVerticalStackView)
    }
    
    thirdHorizontalStackView.snp.makeConstraints {
      $0.top.equalTo(secondHoriziontalStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(secondHoriziontalStackView)
    }
    
    fourthHorizontalStackView.snp.makeConstraints {
      $0.top.equalTo(thirdHorizontalStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(thirdHorizontalStackView)
    }
    
    fifthHoriziontalStackView.snp.makeConstraints {
      $0.top.equalTo(fourthHorizontalStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(fourthHorizontalStackView)
    }
    
    sixthHoriziontalStackView.snp.makeConstraints {
      $0.top.equalTo(fifthHoriziontalStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(fifthHoriziontalStackView)
    }
  }
  
  private func setLottieAnimaiton() {
    let animationView = AnimationView(name: "money")
    lottieView.contentMode = .scaleAspectFit
    lottieView.addSubview(animationView)
    animationView.frame = lottieView.bounds
    animationView.loopMode = .loop
    animationView.play()
  }
  
  
  private func setData() {
    guard let detail = promotionDetail else {return}
    
    mainTitleLabel.text = """
      \(detail.companyName)카드 쓰면
      \(detail.amount)만원 드려요
      """
    
    dateLabel.text = detail.period
    conditionLabel.text = detail.condition
    benefitConditions.text = detail.benefitCondition
    benefitYouGet.text = detail.benefitDetail
    dateYouGet.text = detail.benefitDate
    
  }
  //MARK: - @objc func
  
}
