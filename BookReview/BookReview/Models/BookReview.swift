//
//  BookReview.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/03.
//

import Foundation

struct BookReview : Codable {
  let title : String
  let contents : String
  let imageURL : URL?
}
