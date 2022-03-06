//
//  MockUserDefaultsManager.swift
//  BookReviewTests
//
//  Created by 윤병일 on 2022/03/07.
//

import Foundation

@testable import BookReview

final class MockUserDefaultsManager : UserDefaultsManagerProtocol {
  var isCalledGetReviews = false
  var isCalledSetReview = false
  
  func getReviews() -> [BookReview] {
    isCalledGetReviews = true
    return []
  }
  
  func setReview(_ newValue: BookReview) {
    isCalledSetReview = true
  }
}
