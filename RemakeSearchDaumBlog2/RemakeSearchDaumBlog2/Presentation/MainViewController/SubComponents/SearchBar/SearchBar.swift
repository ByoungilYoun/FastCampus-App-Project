//
//  SearchBar.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar : UISearchBar {
  
  //MARK: - Properties
  private let disposeBag = DisposeBag()
  
  let searchButton = UIButton()
  
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.attribute()
    self.layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  func bind(viewModel : SearchBarViewModel) {
    self.rx.text.bind(to: viewModel.queryText)
      .disposed(by: self.disposeBag)
    
    // searchBar 의 searchButton 탭 되었을때 (키보드에 있는 버튼)
    // 커스텀하게 만든 검색버튼 클릭되었을때
    Observable.merge(
      self.rx.searchButtonClicked.asObservable(),
      searchButton.rx.tap.asObservable()
    )
    .bind(to: viewModel.searchButtonTapped)
    .disposed(by: disposeBag)
    
    
    viewModel.searchButtonTapped
      .asSignal()
      .emit(to: self.rx.endEditing)
      .disposed(by: disposeBag)
  }
  
  private func attribute() {
    searchButton.setTitle("검색", for: .normal)
    searchButton.setTitleColor(.systemBlue, for: .normal)
  }
  
  private func layout() {
    addSubview(searchButton)

    searchTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(12)
      $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
      $0.centerY.equalToSuperview()
    }
    
    searchButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(12)
    }
  }
}


  //MARK: -
extension Reactive where Base : SearchBar {
  var endEditing : Binder<Void> {
    return Binder(base) { base, _ in
      base.endEditing(true)
    }
  }
}
