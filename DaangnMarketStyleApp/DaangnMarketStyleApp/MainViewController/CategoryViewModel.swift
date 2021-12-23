//
//  CategoryViewModel.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/23.
//

import UIKit
import RxSwift
import RxCocoa

struct CategoryViewModel {
  let disposeBag = DisposeBag()
  
  // ViewModel -> View
  let cellData : Driver<[Category]> // 카테고리를 나타낼 셀 데이터
  let pop : Signal<Void> // 선택을 하면 pop 되는 이벤트
  
  // View -> ViewModel
  let itemSelected = PublishRelay<Int>() //선택된 카테고리의 row 값을 내보내기 위해
  
  // ViewModel -> ParentViewModel 
  let selectedCategory = PublishSubject<Category>() // 다른 필요한 메인뷰컨트롤러가 받아서 해당 카테고리를 표현할 수 있도록 전달
  
  init () {
    let categories = [
      Category(id: 1, name: "디지털/가전"),
      Category(id: 2, name: "게임"),
      Category(id: 3, name: "스포츠/레져"),
      Category(id: 4, name: "유아/아동용품"),
      Category(id: 5, name: "여성패션/잡화"),
      Category(id: 6, name: "뷰티/미용"),
      Category(id: 7, name: "남성패션/잡화"),
      Category(id: 8, name: "생활/식품"),
      Category(id: 9, name: "가구"),
      Category(id: 10, name: "도서/티켓/취미"),
      Category(id: 11, name: "기타")
    ]
    
    self.cellData = Driver.just(categories) // 셀 데이터에 카테고리를 전달
    
    self.itemSelected
      .map { categories[$0] } // 아이템이 선택되면 선택된 카테고리가 무엇인지로 변환
      .bind(to: selectedCategory) // 이후 selectedCategory 에 전달된다.
      .disposed(by: self.disposeBag) // 따라서 최종적 외부에서는 selectedCategory 만 확인을 하면 최종적으로 선택한 카테고리가 뭔지를 알 수가있다.
    
    self.pop = itemSelected // 아이템이 선택되었을때 해당 row 와 상관없이 어떤 row 가 선택됬든 void 값으로 전환해서 signal 로 전환한다.
      .map { _ in Void() }
      .asSignal(onErrorSignalWith: .empty())
  }
}
