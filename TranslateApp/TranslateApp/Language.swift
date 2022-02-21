//
//  Language.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import Foundation

enum Language : String, CaseIterable, Codable {
  case ko
  case en
  case ja
  case ch
  
  var title : String {
    switch self {
    case .ko : return "한국어"
    case .en : return "영어"
    case .ja : return "일본어"
    case .ch : return "중국어"
    }
  }
}
