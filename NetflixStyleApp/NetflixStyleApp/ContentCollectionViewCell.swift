//
//  ContentCollectionViewCell.swift
//  NetflixStyleApp
//
//  Created by 윤병일 on 2021/11/14.
//

import UIKit
import SnapKit

class ContentCollectionViewCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "ContentCollectionViewCell"
  
  let imageView = UIImageView()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 5
    contentView.clipsToBounds = true
    
    imageView.contentMode = .scaleAspectFill
    
    contentView.addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
