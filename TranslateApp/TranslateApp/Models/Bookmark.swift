//
//  Bookmark.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import Foundation

struct Bookmark : Codable {
  let sourceLanguage : Language
  let translatedLanguage : Language
  
  let sourceText : String
  let translatedText : String
}
