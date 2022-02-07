//
//  MainModel.swift
//  RemakeDaangnMarketStyleApp
//
//  Created by 윤병일 on 2022/02/08.
//

import Foundation

struct MainModel {
  func setAlert(errorMessage : [String]) -> Alert {
    
    let title = errorMessage.isEmpty ? "성공" : "실패"
    let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
    return (title : title, message : message)
  }
}
