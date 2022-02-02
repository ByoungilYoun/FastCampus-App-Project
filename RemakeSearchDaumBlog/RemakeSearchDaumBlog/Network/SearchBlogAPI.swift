//
//  SearchBlogAPI.swift
//  RemakeSearchDaumBlog
//
//  Created by 윤병일 on 2022/02/03.
//

import Foundation

struct SearchBlogAPI {
  static let scheme = "https"
  static let host = "dapi.kakao.com"
  static let path = "/v2/search/blog"
  
  func searchBlog(query : String) -> URLComponents {
    var components = URLComponents()
    
    components.scheme = SearchBlogAPI.scheme
    components.host = SearchBlogAPI.host
    components.path = SearchBlogAPI.path
    
    components.queryItems = [
      URLQueryItem(name: "query", value: query)
    ]
  
    return components
  }
}
