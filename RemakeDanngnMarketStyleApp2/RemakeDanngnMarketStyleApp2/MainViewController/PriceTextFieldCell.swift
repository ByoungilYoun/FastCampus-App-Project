//
//  PriceTextFieldCell.swift
//  RemakeDanngnMarketStyleApp2
//
//  Created by 윤병일 on 2022/06/18.
//

import UIKit
import RxSwift
import RxCocoa

class PriceTextFieldCell : UITableViewCell {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  let priceInputField = UITextField()
  let freeshareButton = UIButton()
  
  
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
    viewModel.showFreeShareButton // 보여줘 라는 true 값을 받으면
      .map { !$0 } // 반대로 false 로 바꿔서
      .emit(to: freeshareButton.rx.isHidden) // isHidden 을 false 로 해서 보여준다.
      .disposed(by: self.disposeBag)
    
    viewModel.resetPrice
      .map { _ in "" }
      .emit(to: priceInputField.rx.text)
      .disposed(by: self.disposeBag)
    
    priceInputField.rx.text
      .bind(to: viewModel.priceValue)
      .disposed(by: self.disposeBag)
    
    freeshareButton.rx.tap
      .bind(to: viewModel.freeShareButtonTapped)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    freeshareButton.setTitle("무료나눔", for: .normal)
    freeshareButton.setTitleColor(.orange, for: .normal)
    freeshareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    freeshareButton.titleLabel?.font = .systemFont(ofSize: 18)
    freeshareButton.tintColor = .orange
    freeshareButton.layer.borderColor = UIColor.orange.cgColor
    freeshareButton.layer.borderWidth = 1.0
    freeshareButton.layer.cornerRadius = 10.0
    freeshareButton.clipsToBounds = true
    freeshareButton.isHidden = true
    freeshareButton.semanticContentAttribute = .forceRightToLeft
    
    priceInputField.keyboardType = .numberPad
    priceInputField.font = .systemFont(ofSize: 17)
  }
  
  private func layout() {
    [priceInputField, freeshareButton].forEach {
      contentView.addSubview($0)
    }
    
    priceInputField.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(20)
    }
    
    freeshareButton.snp.makeConstraints {
      $0.top.bottom.leading.equalToSuperview().inset(15)
      $0.width.equalTo(100)
    }
  }
}
