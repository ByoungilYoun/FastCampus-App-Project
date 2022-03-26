//
//  MovieContentsStackView.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/26.
//

import SnapKit
import UIKit

final class MovieContentsStackView : UIStackView {
  
  //MARK: - Properties
  private let title : String
  private let contents : String
  
  private lazy var titleLabel : UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14.0, weight: .semibold)
    label.text = title
    return label
  }()
  
  private lazy var contentsLabel : UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14.0, weight: .medium)
    label.text = contents
    return label
  }()
  
  
  //MARK: - init
  init(title : String, contents : String) {
    self.title = title
    self.contents = contents
    super.init(frame: .zero)
    
    configureUI()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    axis = .horizontal
    
    [titleLabel, contentsLabel].forEach {
      self.addArrangedSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.width.equalTo(80.0)
    }
  }
  
}
