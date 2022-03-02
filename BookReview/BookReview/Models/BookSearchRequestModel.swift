//
//  BookSearchRequestModel.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/02.
//

import Foundation

struct BookSearchRequestModel : Codable {
  /// 검색할 책 키워드
  let query : String
}
