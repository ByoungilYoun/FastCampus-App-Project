//
//  TranslateViewController.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import UIKit
import SnapKit

class TranslateViewController : UIViewController {
  
  //MARK: - Properties
  
  private lazy var sourceLanguageButton : UIButton = {
    let button = UIButton()
    button.setTitle("한국어", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    button.setTitleColor(.label, for: .normal)
    button.backgroundColor = .systemBackground
    button.layer.cornerRadius = 9.0
    return button
  }()
  
  private lazy var targetLanguageButton : UIButton = {
    let button = UIButton()
    button.setTitle("영어", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    button.setTitleColor(.label, for: .normal)
    button.backgroundColor = .systemBackground
    button.layer.cornerRadius = 9.0
    return button
  }()
  
  private lazy var buttonStackView : UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.spacing = 8.0
    
    [sourceLanguageButton, targetLanguageButton].forEach {
      stackView.addArrangedSubview($0)
    }
    
    return stackView
  }()
  
  private lazy var resultBaseView : UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private lazy var resultLabel : UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 23, weight: .bold)
    label.textColor = UIColor.mainTintColor
    label.text = "Hello"
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var bookmarkButton : UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "bookmark"), for: .normal)
    return button
  }()
  
  private lazy var copyButton : UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    return button
  }()
  
  private lazy var sourceLabelBaseButton : UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  
  private lazy var sourceLabel : UILabel = {
    let label = UILabel()
    label.text = "텍스트 입력"
    label.textColor = .tertiaryLabel
    //TODO : sourceLabel 에 입력값이 추가되면, placeholder 스타일 해제
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 23.0, weight: .semibold)
    return label
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .secondarySystemBackground
    
    [
      buttonStackView,
      resultBaseView,
      resultLabel,
      bookmarkButton,
      copyButton,
      sourceLabelBaseButton,
      sourceLabel
    ].forEach {
      view.addSubview($0)
    }
    
    let defaultSpacing : CGFloat = 16.0
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.equalToSuperview().inset(defaultSpacing)
      $0.trailing.equalToSuperview().inset(defaultSpacing)
      $0.height.equalTo(50.0)
    }
    
    resultBaseView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
      $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
    }
    
    resultLabel.snp.makeConstraints {
      $0.leading.equalTo(resultBaseView.snp.leading).inset(24.0)
      $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24.0)
      $0.top.equalTo(resultBaseView.snp.top).inset(24.0)
    }
    
    bookmarkButton.snp.makeConstraints {
      $0.leading.equalTo(resultLabel.snp.leading)
      $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
      $0.width.height.equalTo(40.0)
    }
    
    copyButton.snp.makeConstraints {
      $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8.0)
      $0.top.equalTo(bookmarkButton.snp.top)
      $0.width.height.equalTo(40.0)
    }
    
    sourceLabelBaseButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
      $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0.0)
    }
    
    sourceLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(sourceLabelBaseButton).inset(24.0)
    }
  }
}
