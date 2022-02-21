//
//  BookmarkTextStackView.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import UIKit

final class BookmarkTextStackView : UIStackView {
  
  //MARK: - Properties
  private let type : Type
  private let language : Language
  private let text : String
  
  private lazy var languageLabel : UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13.0, weight: .medium)
    label.textColor = type.color
    label.text = language.title
    return label
  }()
  
  private lazy var textLabel : UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16.0, weight: .bold)
    label.textColor = type.color
    label.text = text
    label.numberOfLines = 0 
    return label
  }()
  
  //MARK: - Init
  init(language : Language, text : String, type : Type) {
    self.language = language
    self.text = text
    self.type = type
    
    super.init(frame: .zero)
    configureUI()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    axis = .vertical
    distribution = .equalSpacing
    spacing = 4.0
    
    [languageLabel, textLabel].forEach {
      self.addArrangedSubview($0)
    }
    
    
  }
}
