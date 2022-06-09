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
  
  // seachBar 버튼 탭 이벤트 -> UI 이벤트 이기 때문에 Subject 를 써도 되지만 error 를 방출 안하고 UI 에 더 특성화된 relay 를 사용
  let searchButtonTapped = PublishRelay<Void>()
  
  // searchBar 외부로 내보낼 이벤트
  var shouldLoadResult = Observable<String>.of("")
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.bind()
    self.attribute()
    self.layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func bind() {
    // searchBar 의 searchButton 탭 되었을때 (키보드에 있는 버튼)
    // 커스텀하게 만든 검색버튼 클릭되었을때
    Observable.merge(
      self.rx.searchButtonClicked.asObservable(),
      searchButton.rx.tap.asObservable()
    )
    .bind(to: searchButtonTapped)
    .disposed(by: disposeBag)
    
    
    searchButtonTapped
      .asSignal()
      .emit(to: self.rx.endEditing)
      .disposed(by: disposeBag)
    
    shouldLoadResult = searchButtonTapped // 검색버튼을 눌렀을때
      .withLatestFrom(self.rx.text) { $1 ?? "" } // text 가 빈값이 있으면 "" 을 넣어주고
      .filter { !$0.isEmpty } // 빈값이 없게 하고
      .distinctUntilChanged() // 중복값 없도록 하고 넘겨준다.
    
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
