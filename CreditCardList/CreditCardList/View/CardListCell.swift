//
//  CardListCell.swift
//  CreditCardList
//
//  Created by 윤병일 on 2021/09/19.
//

import UIKit

class CardListCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "CardListCell"
  
  let cardImageView : UIImageView = {
    let v = UIImageView()
    v.image = UIImage(systemName: "creditcard.fill")
    return v
  }()
  
  let cardNameLabel : UILabel = {
    let lb = UILabel()
    lb.text = "신용카드"
    lb.font = UIFont.boldSystemFont(ofSize: 19)
    lb.textColor = .black
    return lb
  }()
  
  let rankingLabel : UILabel = {
    let lb = UILabel()
    lb.text = "0위"
    lb.textColor = .darkGray
    lb.font = UIFont.systemFont(ofSize: 15)
    return lb
  }()
  
  let moneyPayingBackLabel : UILabel = {
    let lb = UILabel()
    lb.text = "0만원 증정"
    lb.textColor = .white
    lb.backgroundColor = .lightGray
    lb.textAlignment = .center
    lb.font = UIFont.boldSystemFont(ofSize: 12)
    return lb
  }()
  
  let nextArrowImageView : UIImageView = {
    let v = UIImageView()
    v.image = UIImage(systemName: "chevron.right")
    v.tintColor = .black
    return v
  }()
  
  //MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    backgroundColor = .white
    
    cardImageView.snp.makeConstraints {
      $0.width.equalTo(80)
      $0.height.equalTo(40)
    }
    
    moneyPayingBackLabel.snp.makeConstraints {
      $0.width.equalTo(70)
      $0.height.equalTo(20)
    }

    
    let subDataStackView = UIStackView(arrangedSubviews: [rankingLabel, moneyPayingBackLabel])
    subDataStackView.axis = .horizontal
    subDataStackView.alignment = .center
    subDataStackView.distribution = .fillProportionally
    
    let cardNameStackView = UIStackView(arrangedSubviews: [subDataStackView, cardNameLabel])
    cardNameStackView.axis = .vertical
    cardNameStackView.alignment = .leading
    cardNameStackView.distribution = .fillEqually
    
    
    let mainNameStackView = UIStackView(arrangedSubviews: [cardImageView, cardNameStackView])
    mainNameStackView.axis = .horizontal
    mainNameStackView.alignment = .center
    mainNameStackView.distribution = .fillProportionally
    
    
    [mainNameStackView, nextArrowImageView].forEach {
      contentView.addSubview($0)
    }
    
    mainNameStackView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    nextArrowImageView.snp.makeConstraints {
      $0.centerY.equalTo(mainNameStackView)
      $0.trailing.equalTo(mainNameStackView.snp.trailing).offset(-20)
      $0.width.height.equalTo(20)
    }
  }
  
  //MARK: - @objc func
  
}
