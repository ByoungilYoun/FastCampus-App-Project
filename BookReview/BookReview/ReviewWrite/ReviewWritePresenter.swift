//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/28.
//

import Foundation

protocol ReviewWriteProtocol {
  func setupNavigationBar()
  func showCloseAlertController()
}

final class ReviewWritePresenter {

  //MARK: - Properties
  private let viewController : ReviewWriteProtocol
  
  //MARK: - init
  
  init(viewController : ReviewWriteProtocol) {
    self.viewController = viewController
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController.setupNavigationBar()
  }
  
  func didTapLeftBarButton() {
    viewController.showCloseAlertController()
  }
}
