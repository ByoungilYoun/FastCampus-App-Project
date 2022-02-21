//
//  BookmarkCollectionViewCell.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import UIKit

class BookmarkCollectionViewCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "BookmarkCollectionViewCell"
  
  private var sourceBookmarkTextStackView : BookmarkTextStackView!
  private var targetBookmarkTextStackView : BookmarkTextStackView!
  
  private lazy var stackView : UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.spacing = 16
    stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    stackView.isLayoutMarginsRelativeArrangement = true
    return stackView
  }()
  
  
  //MARK: - Functions
  func configureUI(from bookMark : Bookmark) {
    backgroundColor = .systemBackground
    layer.cornerRadius = 12.0
    sourceBookmarkTextStackView = BookmarkTextStackView(language: bookMark.sourceLanguage, text: bookMark.sourceText, type: .source)
    targetBookmarkTextStackView = BookmarkTextStackView(language: bookMark.translatedLanguage, text: bookMark.translatedText, type: .target)
    
    stackView.subviews.forEach {
      $0.removeFromSuperview()
    }
    
    [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach {
      stackView.addArrangedSubview($0)
    }
    
    
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
    }
    
   layoutIfNeeded()
  }
}
