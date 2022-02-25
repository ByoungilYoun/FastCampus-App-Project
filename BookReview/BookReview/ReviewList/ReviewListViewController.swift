//
//  ReviewListViewController.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/24.
//

import UIKit
import SnapKit

class ReviewListViewController : UIViewController {
  
  //MARK: - Properties
  private lazy var presenter = ReviewListPresenter(viewController: self)
  
  private lazy var tableView : UITableView = {
    let tableView = UITableView()
    tableView.dataSource = presenter
    return tableView
  }()
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
    
  }
}

  //MARK: - ReviewListProtocol
extension ReviewListViewController : ReviewListProtocol {
  func setupNavigationBar() {
    navigationItem.title = "도서 리뷰"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  func setupViews() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
