//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/22.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
  
  // FilterView 외부에서 필터 눌림 관찰
  let sortButtonTapped = PublishRelay<Void>()
  
  
}
