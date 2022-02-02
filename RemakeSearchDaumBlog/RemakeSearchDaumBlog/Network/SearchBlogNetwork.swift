//
//  SearchBlogNetwork.swift
//  RemakeSearchDaumBlog
//
//  Created by 윤병일 on 2022/02/03.
//

import UIKit
import RxSwift

enum SearchNetworkError : Error {
  case invalidURL
  case invalidJSON
  case networkError
}

class SearchBlogNetwork {
  
  private let session : URLSession
  let api = SearchBlogAPI()
  
  init(session : URLSession = .shared) {
    self.session = session
  }
  
  func searchBlog(query : String) -> Single<Result<DKBlog, SearchNetworkError>> {
    guard let url = api.searchBlog(query: query).url else {
      return .just(.failure(.invalidURL))
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("KakaoAK dac2619e342116fcedac72a794b76476", forHTTPHeaderField: "Authorization")
    
    return session.rx.data(request: request as URLRequest)
      .map { data in
        do {
          let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
          return .success(blogData)
        } catch {
          return .failure(.invalidJSON)
        }
      }
      .catch { _ in
        .just(.failure(.networkError))
      }
      .asSingle()
  }
}
