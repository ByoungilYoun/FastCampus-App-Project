//
//  MovieSearchManager.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/08.
//

import Foundation
import Alamofire

protocol MovieSearchManagerProtocol {
  func request(from keyword : String, completionHandler : @escaping ([Movie]) -> Void)
}

struct MovieSearchManager : MovieSearchManagerProtocol {
  func request(from keyword : String, completionHandler : @escaping ([Movie]) -> Void) {
    guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else {
      return
    }
    
    let parameters = MovieSearchRequestModel(query: keyword)
    
    let headers : HTTPHeaders = [
      "X-Naver-Client-Id" : "YTZZmiKZQOtpVStetdAf",
      "X-Naver-Client-Secret" : "JYQfsLPLWs"
    ]
    
    AF.request(url, method: .get, parameters: parameters, headers: headers)
      .responseDecodable(of: MovieSearchResponseModel.self) { response in
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
