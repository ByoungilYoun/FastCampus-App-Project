//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/01.
//

import UIKit

final class SearchBookViewController : UIViewController {
  
  //MARK: - Properties
  private lazy var presenter = SearchBookPresenter(viewController: self, delegate: searchBookDelegate)
  
  private lazy var tableView : UITableView = {
    let tableView = UITableView()
    tableView.delegate = presenter
    tableView.dataSource = presenter
    return tableView
  }()
  
  private let searchBookDelegate : SearchBookDelegate
  
  //MARK: - Init
  init(searchBookDelegate : SearchBookDelegate) {
    self.searchBookDelegate = searchBookDelegate
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    self.navigationItem.searchController?.dismiss(animated: true)
    self.dismiss(animated: true)
  }
  
  func reloadView() {
    tableView.reloadData()
  }
}
