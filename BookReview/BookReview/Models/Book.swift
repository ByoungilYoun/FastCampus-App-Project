//
//  Book.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/02.
//

import Foundation

struct Book : Decodable {
  let title : String
  private let image : String?
  
  var imageURL : URL? { URL(string: image ?? "") }
}
