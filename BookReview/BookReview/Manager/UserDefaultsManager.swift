//
//  UserDefaultsManager.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/03.
//

import Foundation

protocol UserDefaultsManagerProtocol {
  func getReviews() -> [BookReview]
  func setReview(_ newValue : BookReview)
}

struct UserDefaultsManager : UserDefaultsManagerProtocol {
  enum Key : String {
    case review
  }
  
  func getReviews() -> [BookReview] {
    guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else {
      return []
    }
    
    return (try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? []
  }
  
  func setReview(_ newValue: BookReview) {
    var currentReviews : [BookReview] = getReviews()
    currentReviews.insert(newValue, at: 0) // 최신으로 newValue 를 0번째로 넣어준다.
    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
  }
}
