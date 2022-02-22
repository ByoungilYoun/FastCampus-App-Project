//
//  TranslateResponseModel.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/22.
//

import Foundation

struct TranslateResponseModel : Decodable {
  
  private let message : Message
  
  var translatedText : String { message.result.translatedText }
  
  struct Message : Decodable {
    let result : Result
  }

  struct Result : Decodable {
    let translatedText : String
  }
}
