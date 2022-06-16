//
//  TitleTextFieldCell.swift
//  RemakeDanngnMarketStyleApp2
//
//  Created by 윤병일 on 2022/06/17.
//

import UIKit
import RxSwift
import RxCocoa

class TitleTextFieldCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "TitleTextFieldCell"
  
  let disposeBag = DisposeBag()
  
  let titleInputField = UITextField()
  
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
  func bind(_ viewModel : TitleTextFieldCellViewModel) {
    titleInputField.rx.text
      .bind(to: viewModel.titleText)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    titleInputField.font = .systemFont(ofSize: 17)
  }
  
  private func layout() {
    contentView.addSubview(titleInputField)
    
    titleInputField.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(20)
    }
  }
}
