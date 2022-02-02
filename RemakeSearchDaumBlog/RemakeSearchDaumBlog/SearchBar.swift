//
//  SearchBar.swift
//  RemakeSearchDaumBlog
//
//  Created by 윤병일 on 2022/02/02.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar : UISearchBar {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  let searchButton = UIButton()
  
  // SearchBar 버튼 탭 이벤트, publishSubject 와 거의 동일하지만 에러 이벤트를 받지 않고 UI component 에 특화된 relay를 쓴다.
  let searchButtonTapped = PublishRelay<Void>()
  
  // SearchBar 외부로 내보낼 이벤트 (텍스트)
  var shouldLoadResult = Observable<String>.of("")
  
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func bind() {
    // searchBar의 키보드에 있는 search Button tapped
    // button 이 탭 되었을때
    // 이 두가지를 merge 를 통해서 합친다.
    Observable
      .merge(
        self.rx.searchButtonClicked.asObservable(),
        searchButton.rx.tap.asObservable()
      )
      .bind(to: searchButtonTapped)
      .disposed(by: self.disposeBag)
    
    // searchButtonTapped 이벤트가 발생하면 키보드를 내린다.
    searchButtonTapped
      .asSignal()
      .emit(to: self.rx.endEditing)
      .disposed(by: self.disposeBag)
    
    // text 를 내보낼 shouldLoadResult 는 searchButtonTapped 가 되면 withLatestFrom 트리거를 통해서 최신값을 내보낸다
    self.shouldLoadResult = searchButtonTapped
      .withLatestFrom(self.rx.text) { $1 ?? "" } // 텍스트가 없다면 빈값을 보내줘
      .filter {!$0.isEmpty} // 필터를 통해 빈값을 보내지 않게
      .distinctUntilChanged() // 중복 제거
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

//MARK: - extension Reactive
extension Reactive where Base : SearchBar {
  var endEditing : Binder<Void> {
    return Binder(base) { base, _ in
      base.endEditing(true)
    }
  }
}
