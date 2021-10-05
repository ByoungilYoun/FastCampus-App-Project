//
//  DiaryListCollectionViewCell.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

class DiaryListCollectionViewCell : UICollectionViewCell {
  
  //MARK: - Properties
  
  static let identifier = "DiaryListCollectionViewCell"
  
  let titleLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "하하호호"
    lb.textAlignment = .center
    lb.numberOfLines = 0
    return lb
  }()
  
  let dateLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.text = "20.09.03 (토)"
    lb.textAlignment = .center
    lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    lb.numberOfLines = 0
    return lb
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  //MARK: - Functions
  private func configureUI() {
    backgroundColor = .white
    layer.borderWidth = 1
    layer.borderColor = UIColor.black.cgColor
    
    [titleLabel, dateLabel].forEach {
      contentView.addSubview($0)
    }
    
    
    titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical) // titleLabel 이 아무리 늘어나도 dateLabel 을 침범하지 못하도록
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(12)
      $0.trailing.bottom.equalToSuperview().offset(-12)
    }
    
    dateLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(12)
      $0.trailing.bottom.equalToSuperview().offset(-12)
    }
  }
  
  //MARK: - @objc func
  
}
