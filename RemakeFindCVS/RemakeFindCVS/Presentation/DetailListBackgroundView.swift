//
//  DetailListBackgroundView.swift
//  RemakeFindCVS
//
//  Created by 윤병일 on 2022/02/18.
//

import UIKit
import RxSwift
import RxCocoa

class DetailListBackgroundView : UIView {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  let statusLabel = UILabel()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  
  func bind(_ viewModel : DetailListBackgroundViewModel) {
    viewModel.isStatusLabelHidden
      .emit(to: statusLabel.rx.isHidden)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    backgroundColor = .white
    
    statusLabel.text = "🏪"
    statusLabel.textAlignment = .center
  }
  
  private func layout() {
    addSubview(statusLabel)
    
    statusLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
  }
}
