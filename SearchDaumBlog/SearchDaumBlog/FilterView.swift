//
//  FilterView.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/13.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class FilterView : UITableViewHeaderFooterView {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let sortButton = UIButton()
  let bottomBorder = UIView()
  
  // FilterView 외부에서 필터 눌림 관찰
  let sortButtonTapped = PublishRelay<Void>()
  
  //MARK: - Init
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func bind() {
    sortButton.rx.tap
      .bind(to: sortButtonTapped)
      .disposed(by: disposeBag)
    
  }
  
  private func attribute() {
    sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
    bottomBorder.backgroundColor = .lightGray
  }
  
  private func layout() {
    [sortButton, bottomBorder].forEach {
      addSubview($0)
    }
    
    sortButton.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview().inset(12)
      $0.width.height.equalTo(28)
    }
    
    bottomBorder.snp.makeConstraints {
      $0.top.equalTo(sortButton.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(0.5)
    }
  }
  
}
