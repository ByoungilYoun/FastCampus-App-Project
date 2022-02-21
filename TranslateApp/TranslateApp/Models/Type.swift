//
//  Type.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/22.
//

import UIKit

enum `Type` {
  case source
  case target
  
  var color : UIColor {
    switch self {
    case .source : return .label
    case .target : return UIColor.mainTintColor
    }
  }
}
