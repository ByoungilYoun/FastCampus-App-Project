//
//  MockUserDefaultsManager.swift
//  MovieReviewTests
//
//  Created by 윤병일 on 2022/03/28.
//

import Foundation
@testable import MovieReview

final class MockUserDefaultsManager : UserDefaultsManagerProtocol {
  var isCalledGetMovies = false
  var isCalledAddMovie = false
  var isCalledRemoveMovie = false
  
  func getMovies() -> [Movie] {
    isCalledGetMovies = true
    return []
  }
  
  func addMovie(_ newValue: Movie) {
    isCalledAddMovie = true
  }
  
  func removeMovie(_ value: Movie) {
    isCalledRemoveMovie = true
  }
}
