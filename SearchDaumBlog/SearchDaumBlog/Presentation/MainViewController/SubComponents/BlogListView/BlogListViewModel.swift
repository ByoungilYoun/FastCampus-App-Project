//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/22.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
  
  let filterViewModel = FilterViewModel()
  
  // MainViewController -> BlogListView
  let blogCellData = PublishSubject<[BlogListCellData]>()
  let cellData : Driver<[BlogListCellData]>
  
  init() {
    self.cellData = blogCellData
      .asDriver(onErrorJustReturn: [])//만약에 에러가 나면 빈 어레이를 전달해라
  }
}
