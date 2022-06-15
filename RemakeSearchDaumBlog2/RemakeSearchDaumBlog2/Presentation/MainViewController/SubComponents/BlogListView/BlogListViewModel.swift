//
//  BlogListViewModel.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/15.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
  let filterViewModel = FilterViewModel()
  
  // MainViewController 에서 네트워크 작업을 해서 받아온 값을 BlogListView 로 받아올 이벤트
  let blogCellData = PublishSubject<[BlogListCellData]>()
  let cellData : Driver<[BlogListCellData]>
  
  init() {
    self.cellData = blogCellData
      .asDriver(onErrorJustReturn: [])
  }
}
