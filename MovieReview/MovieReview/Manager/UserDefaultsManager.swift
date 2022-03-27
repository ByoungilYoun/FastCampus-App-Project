//
//  UserDefaultsManager.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/27.
//

import Foundation

protocol UserDefaultsManagerProtocol {
  func getMovies() -> [Movie] // 저장된 영화들을 한번에 가져올 메서드
  func addMovie(_ newValue : Movie)
  func removeMovie(_ value : Movie)
}


struct UserDefaultManager : UserDefaultsManagerProtocol {
  enum Key : String {
    case movie
  }
  
  func getMovies() -> [Movie] {
    guard let data = UserDefaults.standard.data(forKey: Key.movie.rawValue) else {
      return []
    }
    
    return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
  }
  
  func addMovie(_ newValue: Movie) {
    var currentMovies : [Movie] = getMovies()
    currentMovies.insert(newValue, at: 0)
    
    // 새로 저장하기
    saveMovie(currentMovies)
  }
  
  func removeMovie(_ value: Movie) {
    let currentMovies : [Movie] = getMovies()
    let newValue = currentMovies.filter {
      $0.title != value.title // 지우고자 한 값을 제외한 총 movie 값들
    }
    
    // 지우고 새로 저장하기
    saveMovie(newValue)
  }
  
  private func saveMovie(_ newValue : [Movie]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: Key.movie.rawValue)
  }
}
