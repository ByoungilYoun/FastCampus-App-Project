//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/22.
//

import RxSwift
import RxCocoa
import UIKit

struct MainViewModel {
  
  let disposeBag = DisposeBag()
  
  let blogListViewModel = BlogListViewModel()
  let searchBarViewModel = SearchBarViewModel()
  
  let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
  
  let shouldPresentAlert : Signal<MainViewController.Alert>
  
  init(model : MainModel = MainModel()) {
    let blogResult = searchBarViewModel.shouldLoadResult
      .flatMapLatest(model.searchBlog)
      .share()
    
    let blogValue = blogResult // 성공한 데이터 값
      .compactMap(model.getBlogValue)
    
    let blogError = blogResult // 에러
      .compactMap(model.getBlogError)
    
    // 네트워크를 통해 가져온 값을 cellData 로 변환
    let cellData = blogValue
      .map(model.getBlogListCellData)
    
    // FilterView 를 선택했을 때 나오는 alertSheet 를 선택했을때 type
    let sortedType = alertActionTapped
      .filter {
        switch $0 {
        case .title, .datetime :
          return true
        default :
          return false
        }
      }
      .startWith(.title) // 만약 아무도 필터를 건들지 않으면 맨 처음 테이블뷰에 나오는 기준은 title 로 설정
    
    // MainViewController 에서 ListView 로 전달
    Observable
      .combineLatest(sortedType, cellData, resultSelector: model.sort
      )
      .bind(to: blogListViewModel.blogCellData)
      .disposed(by: disposeBag)
    
    let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
      .map { _ -> MainViewController.Alert in
        return (title : nil, message : nil, actions : [.title, .datetime, .cancel], style : .actionSheet)
      }
    
    let alertForErrorMessage = blogError
      .map { message -> MainViewController.Alert in
        return (title : "앗!", message : "예상치 못한 오류가 발생했어요 \(message)", actions : [.confirm], style : .alert)
      }
    
    self.shouldPresentAlert = Observable
      .merge(
        alertSheetForSorting,
        alertForErrorMessage
      )
      .asSignal(onErrorSignalWith: .empty())
    
  }
}
