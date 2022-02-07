//
//  PriceTextFieldCellViewModel.swift
//  RemakeDaangnMarketStyleApp
//
//  Created by 윤병일 on 2022/02/07.
//

import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
  
  //MARK: - Properties
  
  // viewModel -> view
  let showFreeShareButton : Signal<Bool>
  let resetPrice : Signal<Void>
  
  // view -> viewModel
  let priceValue = PublishRelay<String?>()
  
  let freeShareButtonTapped = PublishRelay<Void>()
  
  init() {
    self.showFreeShareButton = Observable
      .merge(
        priceValue.map { $0 ?? "" == "0" },
        freeShareButtonTapped.map { _ in false }
      )
      .asSignal(onErrorJustReturn: false)
    
    self.resetPrice = freeShareButtonTapped
      .asSignal(onErrorSignalWith: .empty())
  }
}
