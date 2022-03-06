//
//  ReviewListPresenterTests.swift
//  ReviewListPresenterTests
//
//  Created by 윤병일 on 2022/02/23.
//

import XCTest
@testable import BookReview

class ReviewListPresenterTests: XCTestCase {

  // 테스트 대상을 변수로 설정 (보통 sut 으로 테스트 대상을 변수 네이밍을 해준다고 한다.)
  var sut : ReviewListPresenter!
  var viewController : MockReviewListViewController!
  var userDefaultsManager : MockUserDefaultsManager!
  
  override func setUp() {
    super.setUp()
    viewController = MockReviewListViewController()
    userDefaultsManager = MockUserDefaultsManager()
    
    sut = ReviewListPresenter(viewController: viewController, userDefaultsManager: userDefaultsManager)
  }
  
  override func tearDown() {
    sut = nil
    viewController = nil
    super.tearDown()
  }
  
  func test_viewDidLoadCalled() {
    sut.viewDidLoad()
    XCTAssertTrue(viewController.isCalledSetupNavigationBar)
    XCTAssertTrue(viewController.isCalledSetupViews)
  }
  
  func test_viewWillAppearCalled() {
    sut.viewWillAppear()
    XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
    XCTAssertTrue(viewController.isCalledReloadTableView)
  }
  
  func test_didTapRightBarButtonItemCalled() {
    sut.didTapRightBarButtonItem()
    XCTAssertTrue(viewController.isCalledPresentToReviewWriteViewController)
  }
}
