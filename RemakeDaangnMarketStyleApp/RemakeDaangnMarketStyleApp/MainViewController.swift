//
//  MainViewController.swift
//  RemakeDaangnMarketStyleApp
//
//  Created by 윤병일 on 2022/02/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController : UIViewController {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let tableView = UITableView()
  
  let summitButton = UIBarButtonItem()
  
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
    
    summitButton.title = "제출"
    summitButton.style = .done
    navigationItem.setRightBarButton(summitButton, animated: true)
    
    tableView.backgroundColor = .white
    tableView.separatorStyle = .singleLine
    tableView.tableFooterView = UIView()
  }
  
  private func layout() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

//MARK: - Alert Extension 
typealias Alert = (title : String, message : String?)

extension Reactive where Base : MainViewController {
  var setAlert : Binder<Alert> {
    return Binder(base) { base, data in
      let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
      let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
      alertController.addAction(action)
      base.present(alertController, animated: true, completion: nil)
    }
  }
}
