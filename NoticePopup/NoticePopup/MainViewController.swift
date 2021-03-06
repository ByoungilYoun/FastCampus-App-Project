//
//  MainViewController.swift
//  NoticePopup
//
//  Created by 윤병일 on 2021/09/24.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class MainViewController : UIViewController {
  
  //MARK: - Properties
  
  var remoteConfig : RemoteConfig?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setRemoteConfigSetting()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getNotice()
  }
  
  //MARK: - Functions
  
  func setRemoteConfigSetting() {
    remoteConfig = RemoteConfig.remoteConfig()
    
    let setting = RemoteConfigSettings()
    setting.minimumFetchInterval = 0 // 테스트를 위해서 새로운 값을 fetch 하는 interval 을 최소화 해서 자주 원격구성에 있는 데이터들을 가져올 수 있도록 설정
    
    remoteConfig?.configSettings = setting
    remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults") // RemoteConfigDefaults.plist 를 기본 default 로 연결해준다.
  }
  
  //MARK: - @objc func
  
}

  //MARK: - RemoteConfig
extension MainViewController {
  func getNotice() {
    guard let remoteConfig = remoteConfig else {return}
    
    remoteConfig.fetch { [weak self] status, _ in
      
      if status == .success {
        remoteConfig.activate(completion: nil)
      } else {
        print("Error : Config not fetched")
      }
     
      guard let self = self else { return }
      
      if !self.isNoticeHidden(remoteConfig) { // hidden 이 false, 즉 notice 를 보여줘야할때
        let noticeVC = NoticeViewController()
        noticeVC.modalPresentationStyle = .custom
        noticeVC.modalTransitionStyle = .crossDissolve
        
        let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n") // firebase 에서는 띄어씌기를 \\n 으로 인식하기 때문에 스위프트에서 가져와서 변환을 \n 으로 해줘야 띄어쓰기를 잘 인식할 수 있다.
        let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
        let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
        
        noticeVC.noticeContents = (title : title, detail : detail, date : date)
        self.present(noticeVC, animated: true, completion: nil)
      } else {
        self.showEventAlert()
      }
    }
  }
  
  func isNoticeHidden(_ remoteConfig : RemoteConfig) -> Bool {
    return remoteConfig["isHidden"].boolValue // 불린값
  }
}

  //MARK: - A/B Testing
extension MainViewController {
  func showEventAlert() {
    guard let remoteConfig = remoteConfig else {return}
    
    remoteConfig.fetch { [weak self] status, _ in
      if status == .success {
        remoteConfig.activate(completion: nil)
      } else {
        print("Error : Config not fetched")
      }
      
      let message = remoteConfig["message"].stringValue ?? "" // 옵셔널 처리
      print("하하하 message : \(message)")
      let confirmAction = UIAlertAction(title: "확인하기", style: .default) { _ in
        // Google Analytics 에서 확인하기, 이벤트 로깅, Firebase Anayltics import 시켜줘야한다.
        Analytics.logEvent("promotion_alert", parameters: nil) //버튼 누를때마다 firebase 에 이벤트 기록
      }
      
      let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
      
      let alertController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
      alertController.addAction(confirmAction)
      alertController.addAction(cancelAction)
      
      self?.present(alertController, animated: true, completion: nil)
    }
  }
}
