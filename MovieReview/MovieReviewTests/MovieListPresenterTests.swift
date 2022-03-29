//
//  MovieListPresenterTests.swift
//  MovieReviewTests
//
//  Created by 윤병일 on 2022/03/28.
//

import XCTest

@testable import MovieReview

class MovieListPresenterTests : XCTestCase {
  
  //MARK: - Properties
  var sut : MovieListPresenter!
  var viewController : MockMovieListViewController!
  var userDefaultsManager : MockUserDefaultsManager!
  var movieSearchManager : MockMovieSearchManager!
  
  
  //MARK: - setUP()
  override func setUp() {
    super.setUp()
    viewController = MockMovieListViewController()
    userDefaultsManager = MockUserDefaultsManager()
    movieSearchManager = MockMovieSearchManager()
    
    sut = MovieListPresenter(viewController: viewController, movieSearchManager: movieSearchManager, userDefaultsManager: userDefaultsManager)
  }
  
  //MARK: - tearDown()
  override func tearDown() {
    sut = nil
    viewController = nil
    userDefaultsManager = nil
    movieSearchManager = nil
    
    super.tearDown()
  }
  
  // request 메서드가 성공하면 updateSearchTableView가 실행되고
  func test_searchBar_textDidChange가_호출될때_request가_성공하면() {
    movieSearchManager.needToSuccessRequest = true
    sut.searchBar(UISearchBar(), textDidChange: "")
    XCTAssertTrue(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행된다.")
  }
  
  // request 메서드가 실패하면 updateSearchTableView가 실행되지 않는다.
  func test_searchBar_textDidChange가_호출될때_request가_실패하면() {
    movieSearchManager.needToSuccessRequest = false
    sut.searchBar(UISearchBar(), textDidChange: "")
    XCTAssertFalse(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행되지 않는다.")
  }
  
  func test_viewDidLoadCalled() {
    sut.viewDidLoad()
    
    XCTAssertTrue(viewController.isCalledSetupNavigationBar)
    XCTAssertTrue(viewController.isCalledSetupSearchBar)
    XCTAssertTrue(viewController.isCalledSetupViews)
  }
  
  func test_viewWillAppearCalled() {
    sut.viewWillAppear()
    
    XCTAssertTrue(userDefaultsManager.isCalledGetMovies)
    XCTAssertTrue(viewController.isCalledUpdateCollectionView)
  }
  
  func test_searchBarTextDidBeginEditingCalled() {
    sut.searchBarTextDidBeginEditing(UISearchBar())
    XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
  }
  
  func test_searchBarCancelButtonClicked() {
    sut.searchBarCancelButtonClicked(UISearchBar())
    XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
  }
}



