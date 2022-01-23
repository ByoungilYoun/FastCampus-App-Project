//
//  RepositoryListViewController.swift
//  RemakeGithubRepository
//
//  Created by 윤병일 on 2022/01/23.
//

import UIKit

class RepositoryListViewController : UITableViewController {
  
  //MARK: - Properties
  private let organization = "Apple"
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    title = organization + "Repositories"
    self.refreshControl = UIRefreshControl()
    let refreshControl = self.refreshControl
    refreshControl?.backgroundColor = .white
    refreshControl?.tintColor = .darkGray
    refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
    refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
    tableView.register(RepositoryListCell.self, forCellReuseIdentifier: RepositoryListCell.identifier)
    tableView.rowHeight = 140
    
  }
  
  //MARK: - @objc func
  @objc func refresh() {
    
  }
}

  //MARK: - UITableview Datasource, Delegate
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
 
