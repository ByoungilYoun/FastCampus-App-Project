//
//  DetailListBackgroundViewModel.swift
//  RemakeFindCVS
//
//  Created by 윤병일 on 2022/02/18.
//

import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
  
  //MARK: - Properties
  
  // viewmodel -> view
  let isStatusLabelHidden : Signal<Bool>
  
  // 외부에서 전달받을 값
  let shouldHideStatusLabel = PublishSubject<Bool>()
  
  init() {
    isStatusLabelHidden = shouldHideStatusLabel
      .asSignal(onErrorJustReturn: true)
  }
}

