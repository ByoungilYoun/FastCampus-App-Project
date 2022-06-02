//
//  RepositoryListViewController.swift
//  RemakeGithubRepository2
//
//  Created by 윤병일 on 2022/06/03.
//

import UIKit

class RepositoryListViewController : UITableViewController {
  
  //MARK: - Properties
  private let organization = "Apple"
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setNavi()
    self.setRefreshControl()
    self.setTableView()
  }
  
  //MARK: - Functions
  private func setNavi() {
    title = organization + "Repositories"
  }
  
  private func setRefreshControl() {
    self.refreshControl = UIRefreshControl()
    let refreshControl = self.refreshControl!
    refreshControl.backgroundColor = .white
    refreshControl.tintColor = .darkGray
    refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }
  
  private func setTableView() {
    tableView.register(RepositoryListCell.self, forCellReuseIdentifier: RepositoryListCell.identifier)
    tableView.rowHeight = 140
  }
  
  //MARK: - @objc func
  @objc private func refresh() {
    
  }
}

  //MARK: - UITableViewDataSource
extension RepositoryListViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryListCell.identifier, for: indexPath) as? RepositoryListCell else {
      return UITableViewCell()
    }
    
    return cell
  }
}
