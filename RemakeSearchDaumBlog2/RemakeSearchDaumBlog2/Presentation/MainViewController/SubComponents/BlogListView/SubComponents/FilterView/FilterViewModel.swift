//
//  FilterViewModel.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/15.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
  // FilterView 외부에서 관찰
  let sortButtonTapped = PublishRelay<Void>()
}
