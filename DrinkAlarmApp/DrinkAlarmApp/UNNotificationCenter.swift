//
//  UNNotificationCenter.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/29.
//

import Foundation
import UserNotifications

// 여기에서 alert 객체를 받아서 request 를 만들고 최종적으로 notification center 에 추가하는 함수를 만들자
extension UNUserNotificationCenter {
  
  func addNotificationRequest(by alert : Alert) {
    let content = UNMutableNotificationContent()
    content.title = "물 마실 시간이에요"
    content.body = "세계보건기구(WHO) 가 권장하는 하루 물 섭취량은 1.5 ~ 2리터 입니다."
    content.sound = .default
    content.badge = 1
    
    // 트리거 설정
    let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
    let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
    
    self.add(request, withCompletionHandler: nil)
  }
}
