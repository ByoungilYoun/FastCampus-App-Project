//
//  MockMovieSearchManager.swift
//  MovieReviewTests
//
//  Created by 윤병일 on 2022/03/28.
//

import Foundation
@testable import MovieReview

final class MockMovieSearchManager : MovieSearchManagerProtocol {
  var isCalledRequest = false
  
  var needToSuccessRequest = false
  
  func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
    isCalledRequest = true
    
    if needToSuccessRequest {
      completionHandler([])
    }
  }
}
