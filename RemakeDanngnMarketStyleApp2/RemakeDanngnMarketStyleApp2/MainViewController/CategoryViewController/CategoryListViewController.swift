//
//  CategoryListViewController.swift
//  RemakeDanngnMarketStyleApp2
//
//  Created by 윤병일 on 2022/06/17.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryListViewController : UIViewController {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  let tableView = UITableView()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    layout()
  }
  
  //MARK: - Functions
  func bind(_ viewModel : CategoryViewModel) {
    viewModel.cellData
      .drive(tableView.rx.items) { tv, row, data in
        let cell = tv.dequeueReusableCell(withIdentifier: "CategoryListCell", for: IndexPath(row: row, section: 0))
        cell.textLabel?.text = data.name
        return cell
      }.disposed(by: self.disposeBag)
    
    viewModel.pop
      .emit(onNext: { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
      })
      .disposed(by: self.disposeBag)
    
    tableView.rx.itemSelected
      .map { $0.row }
      .bind(to: viewModel.itemSelected)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    view.backgroundColor = .systemBackground
    
    tableView.backgroundColor = .white
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
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
