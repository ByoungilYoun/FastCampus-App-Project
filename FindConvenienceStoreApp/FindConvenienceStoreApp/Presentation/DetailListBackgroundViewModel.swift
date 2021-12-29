//
//  DetailListBackgroundViewModel.swift
//  FindConvenienceStoreApp
//
//  Created by 윤병일 on 2021/12/28.
//

import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
  
  // viewModel -> view
  let isStatusLabelHidden : Signal<Bool>
  
  // 외부에서 전달받을 값
  let shouldHideStatusLabel = PublishSubject<Bool>()
  
  init() {
    isStatusLabelHidden = shouldHideStatusLabel
      .asSignal(onErrorJustReturn: true)
  }
}
