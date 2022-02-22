//
//  TranslateRequestModel.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/22.
//

import Foundation

struct TranslateRequestModel : Codable {
  let source : String
  let target : String
  let text : String
  
}
