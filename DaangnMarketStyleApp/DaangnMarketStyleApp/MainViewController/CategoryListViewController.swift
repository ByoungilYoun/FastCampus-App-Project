//
//  CategoryListViewController.swift
//  DaangnMarketStyleApp
//
//  Created by 윤병일 on 2021/12/23.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryListViewController : UIViewController {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  let tableView = UITableView()
  
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
  
  func bind(_ viewModel : CategoryViewModel) {
    viewModel.cellData
      .drive(tableView.rx.items) { tableView, row, data in
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell", for: IndexPath(row: row, section: 0))
        cell.textLabel?.text = data.name
        return cell
      }.disposed(by: self.disposeBag)
    
    viewModel.pop
      .emit(onNext: { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
      }).disposed(by: self.disposeBag)
    
    tableView.rx.itemSelected
      .map { $0.row } // 선택시 row 값만 받겠다.
      .bind(to: viewModel.itemSelected)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    view.backgroundColor = .systemBackground
    self.tableView.backgroundColor = .white
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
    self.tableView.separatorStyle = .singleLine
    self.tableView.tableFooterView = UIView()
  }
  
  private func layout() {
    view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
