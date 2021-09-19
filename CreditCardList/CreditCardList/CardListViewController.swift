//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 윤병일 on 2021/09/19.
//

import UIKit
import SnapKit

class CardListViewController : UIViewController {
  
  //MARK: - Properties
  
  let cardListTableView = UITableView()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    title = "카드 혜택 추천"
    view.backgroundColor = .white
    
    cardListTableView.delegate = self
    cardListTableView.dataSource = self
    cardListTableView.tableFooterView = UIView()
    cardListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    cardListTableView.backgroundColor = .yellow
    view.addSubview(cardListTableView)
   
    cardListTableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  
}

  //MARK: - UITableViewDataSource
extension CardListViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell 
  }
}

  //MARK: - UITableViewDelegate
extension CardListViewController : UITableViewDelegate {
  
}
