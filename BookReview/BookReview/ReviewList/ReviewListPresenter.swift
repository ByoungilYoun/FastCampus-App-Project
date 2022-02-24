//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/24.
//

import Foundation

protocol ReviewListProtocol {
  
}

final class ReviewListPresenter {
  private let viewController : ReviewListProtocol
  
  
  //MARK: - Init
  init(viewController : ReviewListProtocol) {
    self.viewController = viewController
  }
  
  func print() {
    Swift.print("프리젠터에서 프린트됨")
  }
}
