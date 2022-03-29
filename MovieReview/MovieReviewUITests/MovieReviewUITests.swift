//
//  MovieReviewUITests.swift
//  MovieReviewUITests
//
//  Created by 윤병일 on 2022/03/08.
//

import XCTest

class MovieReviewUITests: XCTestCase {

  var app : XCUIApplication!
  
  //MARK: - setUp()
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false //  실패하고 나서도 계속 실행이 안되게끔 하기 위해서
    
    app = XCUIApplication()
    app.launch()
  }
  
  //MARK: - tearDown()
  override func tearDown() {
    super.tearDown()
    app = nil // app을 초기화로 nil 로 설정해준다.
  }
  
  //MARK: - Test Functions
  
  // 네비게이션 타이틀이 영화평점인지 확인하는 메서드
  func test_ifNavigationBarTitleIs영화평점() {
    let existNavigationBarTitle =  app.navigationBars["영화 평점"].exists // app.navigationBar 에서 앱의 모든 네비게이션바를 가져올수 있고 .exist 로 존재하면 true, 존재하지 않으면 false 가 된다.
   XCTAssertTrue(existNavigationBarTitle) // exitNagivationBarTitle 이 true 인지 확인
  }
  
  // SearchBar 가 존재하는지 확인하는 메서드
  func test_ifSearchBarExist() {
    let existSearchBar = app.navigationBars["영화 평점"].searchFields["Search"].exists
    XCTAssertTrue(existSearchBar)
  }
  
  // SearchBar 에 cancel 버튼이 존재하는지 확인하는 메서드
  func test_ifCancelButtonExist() {
    let navigationBar = app.navigationBars["영화 평점"]
    navigationBar.searchFields["Search"].tap() // 네비게이션바의 searchBar placeholder 가 "Search" 인 searchBar 를 tap (누른다)
    
    let existSearchBarCancelButton = navigationBar.buttons["Cancel"].exists // 네비게이션바의 버튼들 중에 Cancel 이라는 이름의 버튼이 있는지
    XCTAssertTrue(existSearchBarCancelButton)
  }
  
  // BDD에 따른 UI Test 작성해보기
  enum CellTitleData : String {
    case existsMovie = "<b>겨울왕국</b> 2"
    case notExistsMovie = "007"
  }
  
  func test_영화가즐겨찾기되어있으면() {
    let existCell = app.collectionViews.cells.containing(.staticText, identifier: CellTitleData.existsMovie.rawValue).element.exists
    
    XCTAssertTrue(existCell, "Title이 표시된 Cell이 존재한다.")
  }
  
  func test_영화가즐겨찾기되어있지않으면() {
    let existCell = app.collectionViews.cells.containing(.staticText, identifier: CellTitleData.notExistsMovie.rawValue).element.exists
    XCTAssertFalse(existCell, "Title이 표시된 Cell이 존재하지 않는다.")
  }
}
