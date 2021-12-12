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
  
  // SearchBar 버튼 탭 이벤트
  let searchButtonTapped = PublishRelay<Void>() // ui 에 특화된, publishsubject 를 래핑하고 있지만 에러를 받지 않는다.
  
  // SearchBar 외부로 내보낼 이벤트
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
    // seachBar search button tapped 검색 실행
    // button tapped  검색 실행
    Observable
      .merge (
        self.rx.searchButtonClicked.asObservable(),
        self.searchButton.rx.tap.asObservable()
      )
      .bind(to: searchButtonTapped)
      .disposed(by: disposeBag)
    
    searchButtonTapped
      .asSignal()
      .emit(to: self.rx.endEditing)
      .disposed(by: disposeBag)
    
    self.shouldLoadResult = searchButtonTapped
      .withLatestFrom(self.rx.text) { // 가장 최신의 searchBar 의 텍스트를 전달한다.
        $1 ?? "" // 없다면 빈값을 보낸다. 옵셔널 처리
      }
      .filter {
        !$0.isEmpty // 빈값이 아닌걸 거른다.
      }
      .distinctUntilChanged() // 동일한 조건을 계속해서 검색해서 불필요한 네트워크가 발생하지 않도록
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
