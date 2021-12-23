//
//  PriceTextFieldCellViewModel.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/23.
//

import Foundation
import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
  
  // ViewModel -> View
  let showFreeShareButton : Signal<Bool>
  let resetPrice : Signal<Void>
  
  // View -> ViewModel
  let priceValue = PublishRelay<String?>()
  let freeShareButtonTapped = PublishRelay<Void>()
  
  init() {
    self.showFreeShareButton = Observable
      .merge(
        priceValue.map { $0 ?? "" == "0"}, // priceValue 가 0값이거나 무료라고 입력했을때
        freeShareButtonTapped.map { _ in false } // freeShareButtonTapped 가 눌렸을때
      )
      .asSignal(onErrorJustReturn: false)
    
    self.resetPrice = freeShareButtonTapped // freeShareButtonTapped 가 선택이 되면 price 를 리셋해줘
      .asSignal(onErrorSignalWith: .empty())
  }
}
