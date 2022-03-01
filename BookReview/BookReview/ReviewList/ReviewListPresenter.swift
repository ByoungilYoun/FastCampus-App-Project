//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/24.
//

import UIKit

protocol ReviewListProtocol {
  func setupNavigationBar()
  func setupViews()
  func presentToReviewWriteViewController()
}

final class ReviewListPresenter : NSObject {
  private let viewController : ReviewListProtocol
  
  
  //MARK: - Init
  init(viewController : ReviewListProtocol) {
    self.viewController = viewController
  }
  
  func viewDidLoad() {
    viewController.setupNavigationBar()
    viewController.setupViews()
  }
  
  func didTapRightBarButtonItem() {
    viewController.presentToReviewWriteViewController()
  }
}

  //MARK: - UITableViewDataSource
extension ReviewListPresenter : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell 
  }
}
