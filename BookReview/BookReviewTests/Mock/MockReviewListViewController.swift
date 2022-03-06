//
//  MockReviewListViewController.swift
//  BookReviewTests
//
//  Created by 윤병일 on 2022/03/07.
//

import Foundation

@testable import BookReview

final class MockReviewListViewController : ReviewListProtocol {
  // 불려졌는지 알수있는 변수
  var isCalledSetupNavigationBar = false
  var isCalledSetupViews = false
  var isCalledPresentToReviewWriteViewController = false
  var isCalledReloadTableView = false
  
  func setupNavigationBar() {
    isCalledSetupNavigationBar = true
  }
  
  func setupViews() {
    isCalledSetupViews = true
  }
  
  func presentToReviewWriteViewController() {
    isCalledPresentToReviewWriteViewController = true
  }
  
  func reloadTableView() {
    isCalledReloadTableView =  true
  }
}
