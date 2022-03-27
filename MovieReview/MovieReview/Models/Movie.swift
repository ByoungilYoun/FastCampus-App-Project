//
//  Movie.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/08.
//

import Foundation

struct Movie : Codable {
  let title : String
  private let image : String
  let userRating : String
  let actor : String
  let director : String
  let pubDate : String
  
  var imageURL : URL? {
    URL(string: image)
  }
  
  init(title: String, imageURL : String, userRating : String, actor : String, director : String, pubDate : String) {
    self.title = title
    self.image = imageURL
    self.userRating = userRating
    self.actor = actor
    self.director = director
    self.pubDate = pubDate
  }
}
