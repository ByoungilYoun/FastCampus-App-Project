//
//  MainViewModel.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/15.
//

import RxSwift
import RxCocoa
import UIKit

struct MainViewModel {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let blogListViewModel = BlogListViewModel()
  let searchBarViewModel = SearchBarViewModel()
  
  let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
  
  let shouldPresentAlert : Signal<MainViewController.Alert>
  
  init(model : MainModel = MainModel()) {
    let blogResult = searchBarViewModel.shouldLoadResult
      .flatMapLatest(model.searchBlog)
      .share() // 스트림 공유
    
    // blogResult 에서 성공한값 (데이터)
    let blogValue = blogResult
      .compactMap(model.getBlogValue)
    
    // blogResult 에서 실패한값 (에러)
    let blogError = blogResult
      .compactMap(model.getBlogError)
    
    let alertForErrorMessage = blogError
      .map { message -> MainViewController.Alert in
        return (title : "앗!", message : "예상치 못한 오류 발생 \(message)", actions : [.confirm], style : .alert)
      }
    
    
    let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
      .map { _ -> MainViewController.Alert in
        return (title : nil, message : nil, actions : [.title, .datetime, .cancel], style : .actionSheet)
      }
    
    
    // 네트워크를 통해 가져온 값을 cellData 로 변환
    let cellData = blogValue
      .map(model.getBlogListCellData)
    
    // FilterView  를 선택했을때 나오는 alertSheet 를 선택했을 때 type
    let sortedType = alertActionTapped
      .filter {
        switch $0 {
        case .title, .datetime :
          return true
        default :
          return false
        }
      }
      .startWith(.title)
    
    // MainViewController -> BlogListView 의 셀 데이터로 전달
    Observable
      .combineLatest(sortedType, cellData, resultSelector: model.sort)
      .bind(to: blogListViewModel.blogCellData)
      .disposed(by: self.disposeBag)
    
    self.shouldPresentAlert = Observable
      .merge(
        alertSheetForSorting, // 필터 눌렀을때 alert 창 나올때
        alertForErrorMessage // 에러 메세지가 있을때 alert 창 나올때
      )
      .asSignal(onErrorSignalWith: .empty())
  }
}

