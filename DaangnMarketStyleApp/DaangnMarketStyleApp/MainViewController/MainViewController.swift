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
    // ViewModel 에서 View 로 전달되는거 먼저
    viewModel.cellData
      .drive(tableView.rx.items) { tableView, row, data in
        switch row {
        case 0 :
          let cell = tableView.dequeueReusableCell(withIdentifier: TitleTextFieldCell.identifier, for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
          cell.selectionStyle = .none
          cell.titleInputField.placeholder = data
          cell.bind(viewModel.titleTextFieldCellViewModel)
          return cell
          
        case 1 :
          let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectCell", for: IndexPath(row: row, section: 0))
          cell.selectionStyle = .none
          cell.textLabel?.text = data
          cell.accessoryType = .disclosureIndicator
          return cell
          
        case 2 :
          let cell = tableView.dequeueReusableCell(withIdentifier: PriceTextFieldCell.identifier, for: IndexPath(row: row, section: 0)) as! PriceTextFieldCell
          cell.selectionStyle = .none
          cell.priceInputField.placeholder = data
          cell.bind(viewModel.priceTextFieldCellViewModel)
          return cell
          
        case 3 :
          let cell = tableView.dequeueReusableCell(withIdentifier: DetailWriteFormCell.identifier, for: IndexPath(row: row, section: 0)) as! DetailWriteFormCell
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
      }).disposed(by: self.disposeBag)
    
    // View 에서 ViewModel 로 전달
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
    self.submitButton.title = "제출"
    self.submitButton.style = .done
    UINavigationBar.appearance().tintColor = UIColor.black // 제출 버튼 색 변경
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black] // 네비 타이틀 색 변경
    self.navigationItem.setRightBarButton(submitButton, animated: true)
    
    self.tableView.backgroundColor = .white
    self.tableView.separatorStyle = .singleLine
    self.tableView.tableFooterView = UIView()
    
    self.tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: TitleTextFieldCell.identifier) // index row 0
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategorySelectCell") // index row 1
    self.tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: PriceTextFieldCell.identifier) // index row 2
    self.tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: DetailWriteFormCell.identifier) // index row 3 
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
