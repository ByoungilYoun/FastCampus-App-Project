//
//  RepositoryListCell.swift
//  RemakeGithubRepository
//
//  Created by 윤병일 on 2022/01/23.
//

import UIKit
import SnapKit

class RepositoryListCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "RepositoryListCell"
  
  var repository : Repository?
  
  let nameLabel = UILabel()
  let descriptionLabel = UILabel()
  let starImageView = UIImageView()
  let starLabel = UILabel()
  let languageLabel = UILabel()
  
  //MARK: - LayoutSubviews
  override func layoutSubviews() {
    super.layoutSubviews()
    
    [nameLabel, descriptionLabel,
     starImageView, starLabel, languageLabel]
      .forEach {
        contentView.addSubview($0)
      }
    
    guard let repository = repository else {
      return
    }

    
    nameLabel.text = repository.name
    nameLabel.textColor = .black
    nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
    
    descriptionLabel.text = repository.description
    descriptionLabel.textColor = .black
    descriptionLabel.font = .systemFont(ofSize: 15, weight: .medium)
    descriptionLabel.numberOfLines = 2
    
    starImageView.image = UIImage(systemName: "star")
    starLabel.text = "\(repository.stargazersCount)"
    starLabel.font = .systemFont(ofSize: 16)
    starLabel.textColor = .gray
    
    languageLabel.text = repository.language
    languageLabel.font = .systemFont(ofSize: 16)
    languageLabel.textColor = .gray
    
    nameLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(18)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(3)
      $0.leading.trailing.equalTo(nameLabel)
    }
    
    starImageView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
      $0.leading.equalTo(descriptionLabel)
      $0.width.height.equalTo(20)
      $0.bottom.equalToSuperview().inset(18)
    }
    
    starLabel.snp.makeConstraints {
      $0.centerY.equalTo(starImageView)
      $0.leading.equalTo(starImageView.snp.trailing).offset(5)
    }
    
    languageLabel.snp.makeConstraints {
      $0.centerY.equalTo(starLabel)
      $0.leading.equalTo(starLabel.snp.trailing).offset(12)
    }
  }
}
