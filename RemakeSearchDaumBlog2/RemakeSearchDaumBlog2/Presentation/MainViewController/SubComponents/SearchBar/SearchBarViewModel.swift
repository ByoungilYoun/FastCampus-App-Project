//
//  SearchBarViewModel.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/15.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
  
  let queryText = PublishRelay<String?>()
  
  // seachBar 버튼 탭 이벤트 -> UI 이벤트 이기 때문에 Subject 를 써도 되지만 error 를 방출 안하고 UI 에 더 특성화된 relay 를 사용
  let searchButtonTapped = PublishRelay<Void>()
  
  let shouldLoadResult : Observable<String>
  
  init() {
    self.shouldLoadResult = searchButtonTapped // 검색버튼을 눌렀을때
      .withLatestFrom(queryText) { $1 ?? "" } // text 가 빈값이 있으면 "" 을 넣어주고
      .filter { !$0.isEmpty } // 빈값이 없게 하고
      .distinctUntilChanged() // 중복값 없도록 하고 넘겨준다.
  }
}
