//
//  MovieDetailPresenterTests.swift
//  MovieReviewTests
//
//  Created by 윤병일 on 2022/03/29.
//

import XCTest
@testable import MovieReview

class MovieDetailPresenterTests : XCTestCase {
  
  var sut : MovieDetailPresenter!
  
  var viewController : MockMovieDetailViewController!
  var movie : Movie!
  var userDefaultsManager : MockUserDefaultsManager!
  
  override func setUp() {
    super.setUp()
    viewController = MockMovieDetailViewController()
    movie = Movie(title: "", imageURL: "", userRating: "", actor: "", director: "", pubDate: "")
    userDefaultsManager = MockUserDefaultsManager()
    
    sut = MovieDetailPresenter(viewController: viewController, movie: movie, userDefaultsManager: userDefaultsManager)
  }
  
  override func tearDown() {
    sut = nil
    viewController = nil
    movie = nil
    userDefaultsManager = nil
    
    super.tearDown()
  }
  
  func test_viewDidLoad() {
    sut.viewDidLoad()
    
    XCTAssertTrue(viewController.isCalledSetupViews)
    XCTAssertTrue(viewController.isCalledSetRightBarButton)
  }
  
  // isLiked = true 일때
  func test_didTapRightBarButtonItemCalledAndIsLikedBeingTrue() {
    movie.isLiked = false
    
    sut = MovieDetailPresenter(viewController: viewController, movie: movie, userDefaultsManager: userDefaultsManager)
    sut.didTapRightBarButtonItem()
    
    XCTAssertTrue(userDefaultsManager.isCalledAddMovie)
    XCTAssertFalse(userDefaultsManager.isCalledRemoveMovie)
    
    XCTAssertTrue(viewController.isCalledSetRightBarButton)
  }
  
  
  // isLiked = false 일때
  func test_didTapRightBarButtonItemCalledAndIsLikedBeingFalse() {
    movie.isLiked = true
    
    sut = MovieDetailPresenter(viewController: viewController, movie: movie, userDefaultsManager: userDefaultsManager)
    
    sut.didTapRightBarButtonItem()
    XCTAssertFalse(userDefaultsManager.isCalledAddMovie)
    XCTAssertTrue(userDefaultsManager.isCalledRemoveMovie)
    
    XCTAssertTrue(viewController.isCalledSetRightBarButton)
  }
}

