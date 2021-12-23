//
//  DetailWriteFormCellViewModel.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/24.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
  
  //MARK: - Properties 
  // View 에서 ViewModel 에 전달될 값
  let contentValue = PublishRelay<String?>()
  
}
