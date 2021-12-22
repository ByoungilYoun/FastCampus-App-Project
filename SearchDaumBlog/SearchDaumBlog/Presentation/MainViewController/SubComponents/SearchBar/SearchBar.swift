//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar : UISearchBar {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let searchButton = UIButton()
  
//  // SearchBar 버튼 탭 이벤트
//  let searchButtonTapped = PublishRelay<Void>() // ui 에 특화된, publishsubject 를 래핑하고 있지만 에러를 받지 않는다.
  
//  // SearchBar 외부로 내보낼 이벤트
//  var shouldLoadResult = Observable<String>.of("")
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func bind(_ viewModel : SearchBarViewModel) {
    self.rx.text
      .bind(to: viewModel.queryText)
      .disposed(by: disposeBag)
    
    // seachBar search button tapped 검색 실행
    // button tapped  검색 실행
    Observable
      .merge (
        self.rx.searchButtonClicked.asObservable(),
        self.searchButton.rx.tap.asObservable()
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


extension Reactive where Base : SearchBar {
  
  var endEditing : Binder<Void> {
    return Binder(base) { base, _ in // base 는 searchBar 를 의미한다.
      base.endEditing(true)
    }
  }
}
