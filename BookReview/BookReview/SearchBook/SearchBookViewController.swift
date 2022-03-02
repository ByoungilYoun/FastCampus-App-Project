//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/01.
//

import UIKit

final class SearchBookViewController : UIViewController {
  
  //MARK: - Properties
  private lazy var presenter = SearchBookPresenter(viewController: self)
  
  private lazy var tableView : UITableView = {
    let tableView = UITableView()
    tableView.delegate = presenter
    tableView.dataSource = presenter
    return tableView
  }()
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

  //MARK: - SearchBookProtocol
extension SearchBookViewController : SearchBookProtocol {
  func setupViews() {
    view.backgroundColor = .systemBackground
    
    let searchController = UISearchController()
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = presenter
    navigationItem.searchController = searchController
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  func dismiss() {
    self.dismiss(animated: true)
  }
  
  func reloadView() {
    tableView.reloadData()
  }
}
