//
//  CustomTableViewCell.swift
//  COVID19
//
//  Created by 윤병일 on 2021/11/02.
//

import UIKit

class CustomTableViewCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "CustomTableViewCell"
  
  let titleLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    return lb
  }()
  
  let countLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    return lb
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
    
    [titleLabel, countLabel].forEach {
      contentView.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(10)
    }
    
    countLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-10)
    }
  }
  
  //MARK: - @objc func
  
}
