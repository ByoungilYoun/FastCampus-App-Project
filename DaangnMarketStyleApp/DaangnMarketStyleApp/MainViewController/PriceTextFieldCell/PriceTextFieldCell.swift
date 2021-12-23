//
//  PriceTextFieldCell.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PriceTextFieldCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "PriceTextFieldCell"
  
  let disposeBag = DisposeBag()
  
  let priceInputField = UITextField()
  
  let freeShareButton = UIButton()
  
  //MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  func bind(_ viewModel : PriceTextFieldCellViewModel) {
    // ViewModel 에서 View로 받는거 먼저
    // 버튼의 보여짐을 제어
    viewModel.showFreeShareButton
      .map { !$0 }
      .emit(to: freeShareButton.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    viewModel.resetPrice
      .map { _ in "" } // 이 이벤트를 받으면 빈 스트링으로 바꾼뒤
      .emit(to: priceInputField.rx.text) // priceInputTextField 에 빈값으로 전달된다.
      .disposed(by: self.disposeBag)
    
    // View 에서 ViewModel 로 전달하는거
    priceInputField.rx.text
      .bind(to: viewModel.priceValue)
      .disposed(by: self.disposeBag)
    
    freeShareButton.rx.tap
      .bind(to: viewModel.freeShareButtonTapped)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    freeShareButton.setTitle("무료나눔", for: .normal)
    freeShareButton.setTitleColor(.orange, for: .normal)
    freeShareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    freeShareButton.titleLabel?.font = .systemFont(ofSize: 18)
    freeShareButton.tintColor = .orange
    freeShareButton.backgroundColor = .white
    freeShareButton.layer.borderColor = UIColor.orange.cgColor
    freeShareButton.layer.borderWidth = 1.0
    freeShareButton.layer.cornerRadius = 10.0
    freeShareButton.isHidden = true
    freeShareButton.semanticContentAttribute = .forceRightToLeft
    
    priceInputField.keyboardType = .numberPad
    priceInputField.font = .systemFont(ofSize: 17)
  }
  
  private func layout() {
    [priceInputField, freeShareButton].forEach {
      contentView.addSubview($0)
    }
    
    priceInputField.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(20)
    }
    
    freeShareButton.snp.makeConstraints {
      $0.top.bottom.leading.equalToSuperview().inset(10)
      $0.width.equalTo(100)
    }
  }
}
