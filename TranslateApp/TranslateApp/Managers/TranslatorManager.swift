//
//  TranslatorManager.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/22.
//

import UIKit
import Alamofire

struct TranslatorManager {
  
  var sourceLanguage : Language = .ko
  var targetLanguage : Language = .en
  
  func translate(from text : String, completionHandler : @escaping (String) -> Void) {
    guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
  
    // url 이 존재한다는 담보가 되어있음
    let requestModel = TranslateRequestModel(source: sourceLanguage.languageCode, target: targetLanguage.languageCode, text: text)
    
    let headers : HTTPHeaders = [
      "X-Naver-Client-Id" : "YPeEdRTzkm5hsyvxPF9M",
      "X-Naver-Client-Secret" : "Cgn_03nnC3"
    ]
    
    AF.request(url, method: .post, parameters: requestModel, headers: headers)
      .responseDecodable(of: TranslateResponseModel.self) { response in
        switch response.result {
        case .success(let result) :
          completionHandler(result.translatedText)
        case .failure(let error) :
          print(error.localizedDescription)
        }
      }
      .resume()
  }
}
