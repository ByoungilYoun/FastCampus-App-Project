//
//  ContentCollectionViewHeader.swift
//  NetflixStyleApp
//
//  Created by 윤병일 on 2021/11/14.
//

import UIKit

class ContentCollectionViewHeader : UICollectionReusableView {
  
  //MARK: - Properties
  static let identifier = "ContentCollectionViewHeader"
  
  let sectionNameLabel = UILabel()
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
    sectionNameLabel.textColor = .white
    sectionNameLabel.sizeToFit()
    
    addSubview(sectionNameLabel)
    
    sectionNameLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.top.bottom.leading.equalToSuperview().offset(10)
    }
  }
}
