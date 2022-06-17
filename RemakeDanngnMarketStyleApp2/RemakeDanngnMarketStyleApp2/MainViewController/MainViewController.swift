//
//  MainViewController.swift
//  RemakeDanngnMarketStyleApp2
//
//  Created by 윤병일 on 2022/06/16.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

typealias Alert = (title : String, message : String?)

class MainViewController : UIViewController {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let tableView = UITableView()
  let submitButton = UIBarButtonItem()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    layout()
  }
  
  //MARK: - Functions
  func bind(_ viewModel : MainViewModel) {
    
  }
  
  private func attribute() {
    title = "중고거래 글쓰기"
    view.backgroundColor = .white
    
    submitButton.title = "제출"
    submitButton.style = .done
    
    navigationItem.setRightBarButton(submitButton, animated: true)
    
    tableView.backgroundColor = .white
    tableView.separatorStyle = .singleLine
    tableView.tableFooterView = UIView()
    
    tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: TitleTextFieldCell.identifier)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategorySelectCell")
    tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: PriceTextFieldCell.identifier)
    tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: DetailWriteFormCell.identifier)
  }
  
  private func layout() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}


  //MARK: - Reactive Extension

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
