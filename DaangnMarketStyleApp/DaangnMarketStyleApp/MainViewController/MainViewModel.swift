//
//  MainViewModel.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/23.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
  
  //MARK: - Properties
  let titleTextFieldCellViewModel = TitleTextFieldCellViewModel()
  let priceTextFieldCellViewModel = PriceTextFieldCellViewModel()
  let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
  
  // ViewModel -> View
  let cellData : Driver<[String]> // 메인뷰가 가지고 있는 셀 데이터
  let presentAlert : Signal<Alert> // alert 을 띄워야 하는 signal
  let push : Driver<CategoryViewModel>// 카테고리를 누르면 카테고리 뷰컨으로 푸시를 하는
  
  // View -> ViewModel
  let itemSelected = PublishRelay<Int>() // 아이템이 선택된 subject (row 들)
  let submitButtonTapped = PublishRelay<Void>() // 제출 버튼 선택되는 subject
  
  //MARK: - Init
  init(model : MainModel = MainModel()) {
    let title = Observable.just("글 제목") // 첫번째 셀 제목
    
    let categoryViewModel = CategoryViewModel()
    let category = categoryViewModel // 두번째 셀 제목
      .selectedCategory
      .map {
        $0.name
      }
      .startWith("카테고리 선택") // 시작은 카테고리 선택
    
    let price = Observable.just("$ 가격 (선택사항)") // 세번째 셀 제목
    let detail = Observable.just("내용을 입력하세요")
    
    self.cellData = Observable
      .combineLatest(title,
                     category,
                     price,
                     detail
      ) { [$0, $1, $2, $3] } // 어레이로 묶여져서 전달된다.
      .asDriver(onErrorJustReturn: [])
    
    let titleMessage = titleTextFieldCellViewModel.titleText
      .map { $0?.isEmpty ?? true } // 만약 비어져있으면 true
      .startWith(true) // 처음에는 아무값도 입력 안되있기 때문에 true 를 준다.
      .map { $0 ? ["- 글 제목을 입력해주세요."] : [] } // true 면 글 제목을 입력해주세요 아니면 아무것도 전달하지 않는다.
    
    let categoryMessage = categoryViewModel.selectedCategory
      .map { _ in false } // false 로 시작, 만약 선택된 카테고리가 있다면 아무것도 보여주지 않을것이기 때문에 false
      .startWith(true) // 가장 처음에는 아무 카테고리도 선택되지 않았기 때문에 true
      .map { $0 ? ["- 카테고리를 선택해주세요."] : [] }
    
    let detailMessage = detailWriteFormCellViewModel.contentValue
      .map { $0?.isEmpty ?? true }
      .startWith(true)
      .map { $0 ? ["- 내용을 입력해주세요"] : [] }
    
    let errorMessage = Observable
      .combineLatest(titleMessage, categoryMessage, detailMessage) {
        $0 + $1 + $2
      }
    
    self.presentAlert = submitButtonTapped
      .withLatestFrom(errorMessage) // 트리거로 withLatestFrom 을 쓴다.
      .map(model.setAlert)
      .asSignal(onErrorSignalWith: .empty())
    
    self.push = itemSelected
      .compactMap { row -> CategoryViewModel? in
        guard case 1 = row else {
          return nil
        }
        
        return categoryViewModel
      }
      .asDriver(onErrorDriveWith: .empty())
  }
}
