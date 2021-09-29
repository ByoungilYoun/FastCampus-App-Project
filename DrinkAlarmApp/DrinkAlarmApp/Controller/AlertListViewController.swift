//
//  AlertListViewController.swift
//  DrinkAlarmApp
//
//  Created by 윤병일 on 2021/09/28.
//

import UIKit

class AlertListViewController : UIViewController {
  
  //MARK: - Properties
  let alertListTableView = UITableView()
  
  var alerts : [Alert] = []
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavi()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    alerts = alertList() // 유저 디폴트에서 가져온 데이터를 alerts 배열에 넣어준다.
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    self.alertListTableView.delegate = self
    self.alertListTableView.dataSource = self
    self.alertListTableView.tableFooterView = UIView()
    self.alertListTableView.register(AlertListCell.self, forCellReuseIdentifier: AlertListCell.identifier)
    view.addSubview(alertListTableView)
    
    alertListTableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func configureNavi() {
    title = "물마시기"
//    self.navigationController?.navigationBar.backgroundColor = .lightGray //  ios 15 에서 네비게이션 바 백그라운드 색상 변경하는 방법
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.black] // 네비게이션 타이틀 폰트 색변경
    self.navigationController?.navigationBar.tintColor = .black // 바 버튼 색상 변경 방법
    let plusTimeBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBtnTap) )
    self.navigationItem.rightBarButtonItem = plusTimeBarButton
    
  }
  
  func alertList() -> [Alert] {
    guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data, // 유저 디폴트는 우리가 만든 [Alert] 커스텀 구조체를 이해하지 못하기 때문에 넣고 뺄때 인코딩, 디코딩을 해줘야한다.
          let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] }
    return alerts
  }
  
  //MARK: - @objc func
  @objc func plusBtnTap() {
    let vc = AddAlertViewController()
    vc.pickedDate = { [weak self] date in
      guard let self = self else { return }
      
      var alertList = self.alertList()
      let newAlert = Alert(date: date, isOn: true)
      
      alertList.append(newAlert)
      alertList.sort {
        $0.date < $1.date
      }
      
      self.alerts = alertList
      
      UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts") // 인코딩을 하고 유저디폴트에 저장해준다.
    
      self.alertListTableView.reloadData()
      
    }
    navigationController?.pushViewController(vc, animated: true)
  }
}

  //MARK: - UITableViewDataSource
extension AlertListViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alerts.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0 :
      return "🚰 물마실 시간"
    default :
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AlertListCell.identifier, for: indexPath) as? AlertListCell else {
      return UITableViewCell()
    }
    cell.alarmSwitch.isOn = alerts[indexPath.row].isOn
    cell.clockLabel.text = alerts[indexPath.row].time
    cell.amPmLabel.text = alerts[indexPath.row].meridiem
    cell.alarmSwitch.tag = indexPath.row
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

  //MARK: - UITableViewDelegate
extension AlertListViewController : UITableViewDelegate {
  // 테이블 row 지우는 방법
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete :
      self.alerts.remove(at: indexPath.row)
      UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
      self.alertListTableView.reloadData()
      return
    default :
      break
    }
  }
}
