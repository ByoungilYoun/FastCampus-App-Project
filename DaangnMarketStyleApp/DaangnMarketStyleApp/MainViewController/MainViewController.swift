//
//  MainViewController.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController : UIViewController {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let tableView = UITableView()
  let submitButton = UIBarButtonItem()
  
  //MARK: - Init
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  func bind(_ viewModel : MainViewModel) {
    
  }
  
  private func attribute() {
    title = "중고거래 글쓰기"
    
    view.backgroundColor = .white
    self.submitButton.title = "제출"
    self.submitButton.style = .done
    UINavigationBar.appearance().tintColor = UIColor.black // 제출 버튼 색 변경
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black] // 네비 타이틀 색 변경
    self.navigationItem.setRightBarButton(submitButton, animated: true)
    
    self.tableView.backgroundColor = .white
    self.tableView.separatorStyle = .singleLine
    self.tableView.tableFooterView = UIView()
    
    self.tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: TitleTextFieldCell.identifier) // index row 0
    
    
  }
  
  private func layout() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

typealias Alert = (title : String, message : String?)

  //MARK: - Reactive Extension
extension Reactive where Base : MainViewController {
  var setAlert : Binder<Alert> {
    return Binder(base) { base, data in // base 는 MainViewController, data 는 Alert안에 있는 정보
      let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
      let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
      alertController.addAction(action)
      base.present(alertController, animated: true, completion: nil)
    }
  }
}
