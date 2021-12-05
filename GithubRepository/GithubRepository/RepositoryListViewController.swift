//
//  RepositoryListViewController.swift
//  GithubRepository
//
//  Created by 윤병일 on 2021/12/06.
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
    view.backgroundColor = .white
    
    title = organization + "Reporitories"
    
    self.refreshControl = UIRefreshControl() // 당겨서 새로고침
    let refroshControl = self.refreshControl!
    refroshControl.backgroundColor = .white
    refroshControl.tintColor = .darkGray
    refroshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
    refroshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
    tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
    tableView.rowHeight = 140
  }
  
  
  //MARK: - @objc func
  @objc func refresh(){
    
  }
}

  //MARK: - UITableView Datasource, Delegate
extension RepositoryListViewController  {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListCell", for: indexPath) as? RepositoryListCell else {
      return UITableViewCell()
    }
    
    return cell
  }
}
