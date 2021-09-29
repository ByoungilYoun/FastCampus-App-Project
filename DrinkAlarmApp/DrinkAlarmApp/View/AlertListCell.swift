//
//  AlertListCell.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/29.
//

import Foundation
import UIKit
import UserNotifications

class AlertListCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "AlertListCell"
  
  let userNotificationCenter = UNUserNotificationCenter.current()
  
  let amPmLabel : UILabel = {
    let lb = UILabel()
    lb.text = "오전"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 28)
    return lb
  }()
  
  let clockLabel : UILabel = {
    let lb = UILabel()
    lb.text = "00:00"
    lb.font = UIFont.systemFont(ofSize: 50)
    lb.textColor = .black
    return lb
  }()
  
  let alarmSwitch : UISwitch = {
    let sw = UISwitch()
    sw.addTarget(self, action: #selector(alertSwitchValueChanged), for: .valueChanged)
    return sw
  }()
  
  //MARK: - init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    backgroundColor = .white
    
    [amPmLabel, clockLabel, alarmSwitch].forEach {
      contentView.addSubview($0)
    }
    
    amPmLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.bottom.equalTo(clockLabel).offset(-8)
    }
    
    clockLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(amPmLabel.snp.trailing)
    }
    
    alarmSwitch.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerY.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  @objc func alertSwitchValueChanged(_ sender : UISwitch) {
    guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
          var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {return}
    
    alerts[sender.tag].isOn = sender.isOn
    UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
    
    if sender.isOn {
      userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
    } else {
      userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
    }
  }
}
