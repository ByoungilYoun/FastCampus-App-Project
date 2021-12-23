//
//  DetailWriteFormCell.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/24.
//

import UIKit
import RxSwift
import RxCocoa

class DetailWriteFormCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "DetailWriteFormCell"
  
  let disposeBag = DisposeBag()
  
  let contentInputView = UITextView()
  
  
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
  func bind(_ viewModel : DetailWriteFormCellViewModel) {
    contentInputView.rx.text
      .bind(to: viewModel.contentValue)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    contentInputView.font = .systemFont(ofSize: 17)
  }
  
  private func layout() {
    contentView.addSubview(contentInputView)
    
    contentInputView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(15)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(300)
    }
  }
}
