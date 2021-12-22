//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/22.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
  let queryText = PublishRelay<String?>()
  
  // SearchBar 버튼 탭 이벤트
  let searchButtonTapped = PublishRelay<Void>() // ui 에 특화된, publishsubject 를 래핑하고 있지만 에러를 받지 않는다.
  
  let shouldLoadResult : Observable<String>
  
  
  init() {
    self.shouldLoadResult = searchButtonTapped
      .withLatestFrom(queryText) { // 가장 최신의 searchBar 의 텍스트를 전달한다.
        $1 ?? "" // 없다면 빈값을 보낸다. 옵셔널 처리
      }
      .filter {
        !$0.isEmpty // 빈값이 아닌걸 거른다.
      }
      .distinctUntilChanged() // 동일한 조건을 계속해서 검색해서 불필요한 네트워크가 발생하지 않도록
  }
}
