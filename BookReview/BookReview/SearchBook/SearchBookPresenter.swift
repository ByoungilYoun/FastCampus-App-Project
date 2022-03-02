//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/01.
//

import UIKit

protocol SearchBookProtocol {
  func setupViews()
  func dismiss()
}

final class SearchBookPresenter : NSObject {
  
  //MARK: - Properties
  private let viewController : SearchBookProtocol
  
  //MARK: - init
  init(viewController : SearchBookProtocol) {
    self.viewController = viewController
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController.setupViews()
  }
}

  //MARK: - UISearchBarDelegate
extension SearchBookPresenter : UISearchBarDelegate {
  
}

  //MARK: - UITableViewDelegate
extension SearchBookPresenter : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewController.dismiss()
  }
}

  //MARK: - UITableViewDataSource
extension SearchBookPresenter : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}
