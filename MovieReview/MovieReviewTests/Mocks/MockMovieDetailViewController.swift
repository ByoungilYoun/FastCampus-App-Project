//
//  MockMovieDetailViewController.swift
//  MovieReviewTests
//
//  Created by 윤병일 on 2022/03/29.
//

import Foundation
@testable import MovieReview

final class MockMovieDetailViewController : MovieDetailProtocol {
  var isCalledSetupViews = false
  var isCalledSetRightBarButton = false
  
  var setIsLiked = false
  
  func setupViews(with movie: Movie) {
    isCalledSetupViews = true
  }
  
  func setRightBarButton(with isLiked: Bool) {
    setIsLiked = isLiked
    isCalledSetRightBarButton = true
  }
}
