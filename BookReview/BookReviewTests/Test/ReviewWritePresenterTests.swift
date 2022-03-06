//
//  ReviewWritePresenterTests.swift
//  BookReviewTests
//
//  Created by 윤병일 on 2022/03/07.
//

import XCTest

@testable import BookReview

class ReviewWritePresenterTests : XCTestCase {
  
  var sut : ReviewWritePresenter!
  var viewController : MockReviewWriteViewController!
  var userDefaultsManager : MockUserDefaultsManager!
  
  override func setUp() {
    super.setUp()
    viewController = MockReviewWriteViewController()
    userDefaultsManager = MockUserDefaultsManager()
    
    sut = ReviewWritePresenter(viewController: viewController, userDefaultsManager: userDefaultsManager)
  }
  
  override func tearDown() {
    sut = nil
    
    viewController = nil
    userDefaultsManager = nil
    super.tearDown()
  }
  
  func test_viewDidLoadCalled() {
    sut.viewDidLoad()
    
    XCTAssertTrue(viewController.isCalledSetupNavigationBar)
    XCTAssertTrue(viewController.isCalledSetupViews)
  }
  
  func test_didTapLeftBarButtonCalled() {
    sut.didTapLeftBarButton()
    
    XCTAssertTrue(viewController.isCalledShowCloseAlertController)
  }
  
  func test_didTapRightBarButtonCalledWithoutBook() { // book 이 존재하지 않을때
    sut.book = nil
    sut.didTapRightBarButton(contentsText: "참 공부하기 좋은 책이에요")
    
    XCTAssertFalse(userDefaultsManager.isCalledSetReview)
    XCTAssertFalse(viewController.isCalledClose)
  }
  
  func test_didTapRightBarButtonCalled() {
    sut.book = Book(title: "Swift", imageUrl: "https://")
    sut.didTapRightBarButton(contentsText: "참 공부하기 좋은 책이에요")
    
    XCTAssertTrue(userDefaultsManager.isCalledSetReview)
    XCTAssertTrue(viewController.isCalledClose)
  }
  
  func test_didTapBookTitleButtonCalled() {
    sut.didTapBookTitleButton()
    
    XCTAssertTrue(viewController.isCalledPresentToSearchBookViewController)
  }
}

final class MockReviewWriteViewController : ReviewWriteProtocol {
  var isCalledSetupNavigationBar = false
  var isCalledShowCloseAlertController = false
  var isCalledClose = false
  var isCalledSetupViews = false
  var isCalledPresentToSearchBookViewController = false
  var isCalledUpdateViews = false
  
  func setupNavigationBar() {
    isCalledSetupNavigationBar = true
  }
  
  func showCloseAlertController() {
    isCalledShowCloseAlertController = true
  }
  
  func close() {
    isCalledClose = true
  }
  
  func setupViews() {
    isCalledSetupViews = true
  }
  
  func presentToSearchBookViewController() {
    isCalledPresentToSearchBookViewController = true
  }
  
  func updateViews(title: String, imageUrl: URL?) {
    isCalledUpdateViews = true
  }
}
