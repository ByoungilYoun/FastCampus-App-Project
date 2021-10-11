//
//  FavoriteCollectionViewCell.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

class FavoriteCollectionViewCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "FavoriteCollectionViewCell"
  
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
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.black.cgColor
    layer.cornerRadius = 3.0
    
    let stack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
    stack.axis = .vertical
    stack.spacing = 12
    
    contentView.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
  }
  
  //MARK: - @objc func
  
}
