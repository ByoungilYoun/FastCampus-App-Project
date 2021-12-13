//
//  SearchBlogNetwork.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/13.
//


import RxSwift
import Foundation

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
  
  func searchBlog(query : String) -> Single<Result<DaumKakaoBlog, SearchNetworkError>> {
    guard let url = api.searchBlog(query: query).url else {
      return .just(.failure(.invalidURL))
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("KakaoAK 0f6e6c3fbbc44ec97fb2b113f89b4038 ", forHTTPHeaderField: "Authorization")
    return session.rx.data(request: request as URLRequest)
      .map { data in
        do {
          let blogData = try JSONDecoder().decode(DaumKakaoBlog.self, from: data)
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
