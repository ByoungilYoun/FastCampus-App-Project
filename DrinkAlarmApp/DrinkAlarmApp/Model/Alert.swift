//
//  Alert.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/29.
//

import Foundation

struct Alert : Codable {
  var id : String = UUID().uuidString
  let date : Date // 시간
  var isOn : Bool
  
  var time : String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "hh:mm" // 00시 00분 변환
    return timeFormatter.string(from: date)
  }
  
  var meridiem : String {
    let meridiemFormatter = DateFormatter()
    meridiemFormatter.dateFormat = "a" // 오전인지 오후인지 변환
    meridiemFormatter.locale = Locale(identifier: "ko")
    return meridiemFormatter.string(from: date)
  }
}
