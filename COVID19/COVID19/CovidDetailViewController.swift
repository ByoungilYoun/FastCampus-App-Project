//
//  CovidDetailViewController.swift
//  COVID19
//
//  Created by 윤병일 on 2021/11/02.
//

import UIKit

class CovidDetailViewController : UIViewController {
  
  //MARK: - Properties
  
  let detailTableView = UITableView()
  
  let detailTableViewTitle = ["신규 확진자", "확진자", "완치자", "사망자", "발생률", "해외유입 신규 확진자", "지역발생 신규 확진자"]
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    detailTableView.dataSource = self
    detailTableView.delegate = self
    detailTableView.tableFooterView = UIView()
    detailTableView.backgroundColor = .white
    detailTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    view.addSubview(detailTableView)
    
    detailTableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

  //MARK: - UITableViewDataSource
extension CovidDetailViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return detailTableViewTitle.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell() }
    cell.titleLabel.text = detailTableViewTitle[indexPath.row]
    return cell 
  }
}

  //MARK: - UITableViewDelegate
extension CovidDetailViewController : UITableViewDelegate {
  
}
