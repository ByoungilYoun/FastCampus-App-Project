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
    viewModel.cellData
      .drive(tableView.rx.items) { tv, row, data in
        switch row {
        case 0 :
          let cell = tv.dequeueReusableCell(withIdentifier: TitleTextFieldCell.identifier, for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
          cell.selectionStyle = .none
          cell.titleInputField.placeholder = data
          cell.bind(viewModel.titleTextFieldCellViewModel)
          return cell
        case 1 :
          let cell = tv.dequeueReusableCell(withIdentifier: "CategorySelectCell", for: IndexPath(row: row, section: 0))
          cell.selectionStyle = .none
          cell.textLabel?.text = data
          cell.accessoryType = .disclosureIndicator
          return cell
        case 2 :
          let cell = tv.dequeueReusableCell(withIdentifier: PriceTextFieldCell.identifier, for: IndexPath(row: row, section: 0)) as! PriceTextFieldCell
          cell.selectionStyle = .none
          cell.priceInputField.placeholder = data
          cell.bind(viewModel.priceTextFieldCellViewModel)
          return cell
        case 3:
          let cell = tv.dequeueReusableCell(withIdentifier: DetailWriteFormCell.identifier, for: IndexPath(row: row, section: 0)) as! DetailWriteFormCell
          cell.selectionStyle = .none
          cell.contentInputView.text = data
          cell.bind(viewModel.detailWriteFormCellViewModel)
          return cell
        default :
          fatalError()
        }
      }.disposed(by: self.disposeBag)
    
    viewModel.presentAlert
      .emit(to: self.rx.setAlert)
      .disposed(by: self.disposeBag)
    
    viewModel.push
      .drive(onNext: { viewModel in
        let viewController = CategoryListViewController()
        viewController.bind(viewModel)
        self.show(viewController, sender: nil)
      })
      .disposed(by: self.disposeBag)
    
    tableView.rx.itemSelected
      .map { $0.row }
      .bind(to: viewModel.itemSelected)
      .disposed(by: self.disposeBag)
    
    submitButton.rx.tap
      .bind(to: viewModel.submitButtonTapped)
      .disposed(by: self.disposeBag)
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
