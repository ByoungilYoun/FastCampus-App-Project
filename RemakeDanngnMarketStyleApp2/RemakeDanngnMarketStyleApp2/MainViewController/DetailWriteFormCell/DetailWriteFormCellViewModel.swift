//
//  DetailWriteFormCellViewModel.swift
//  RemakeDanngnMarketStyleApp2
//
//  Created by 윤병일 on 2022/06/18.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
  
  // View -> ViewModel
  let contentValue = PublishRelay<String?>()
}
