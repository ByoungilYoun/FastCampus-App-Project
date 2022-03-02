//
//  BookSearchManager.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/02.
//

import Foundation
import Alamofire

struct BookSearchManager {
  func request(from keyword : String, completionHandler : @escaping (([Book]) -> Void)) {
    guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else {
      return
    }
    
    let parameters = BookSearchRequestModel(query: keyword)
    
    let headers : HTTPHeaders = [
      "X-Naver-Client-Id" : "kjcSUeR7bDkE8e832CHi",
      "X-Naver-Client-Secret" : "XXCAfrJ1WL"
    ]
    
    AF.request(url, method: .get, parameters: parameters, headers: headers)
      .responseDecodable(of: BookSearchResponseModel.self) { response in
        switch response.result {
        case .success(let result) :
          completionHandler(result.items)
        case .failure(let error) :
          print(error.localizedDescription)
        }
      }
      .resume()
  }
}
