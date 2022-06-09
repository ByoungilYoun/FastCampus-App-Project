//
//  SearchBlogNetwork.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/10.
//

import Foundation
import RxSwift

enum SearchNetworkError : Error {
  case invalidURL
  case invalidJSON
  case networkError
}

class SearchBlogNetwork {
  
  //MARK: - Properties
  private let session : URLSession
  
  let api = SearchBlogAPI()
  
  //MARK: - Init
  init(session : URLSession = .shared) {
    self.session = session
  }
  
  func searchBlog(query : String) -> Single<Result<DKBlog, SearchNetworkError>> {
    guard let url = api.searchBlog(query: query).url else {
      return .just(.failure(.invalidURL))
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("KakaoAK 67416ba3d103328656bf824e8a5f935e", forHTTPHeaderField: "Authorization")
    
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
