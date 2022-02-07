//
//  TitleTextFieldCell.swift
//  RemakeDaangnMarketStyleApp
//
//  Created by 윤병일 on 2022/02/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TitleTextFieldCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "TitleTextFieldCell"
  
  let disposeBag = DisposeBag()
  
  let titleInputField = UITextField()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  
  func bind(_ viewModel : TitleTextFieldCellViewModel) {
    titleInputField.rx.text
      .bind(to: viewModel.titleText)
      .disposed(by: disposeBag)
  }
  
  private func attribute() {
    titleInputField.font = .systemFont(ofSize: 17)
    titleInputField.textColor = .black
  }
  
  private func layout() {
    contentView.addSubview(titleInputField)
    
    titleInputField.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(20)
    }
  }
}
