//
//  RepositoryListCell.swift
//  RemakeGithubRepository2
//
//  Created by 윤병일 on 2022/06/03.
//

import UIKit
import SnapKit

class RepositoryListCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "RepositoryCell"
  
  var repository : String?
  
  let nameLabel = UILabel()
  let descriptionLabel = UILabel()
  let starImageView = UIImageView()
  let starLabel = UILabel()
  let languageLabel = UILabel()
  
  //MARK: - layoutSubviews
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layout()
  }
  
  //MARK: - Functions
  private func layout() {
    [nameLabel, descriptionLabel,
     starImageView, starLabel, languageLabel
    ].forEach {
      contentView.addSubview($0)
    }
  }
}
