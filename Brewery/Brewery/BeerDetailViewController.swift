//
//  BeerDetailViewController.swift
//  Brewery
//
//  Created by 윤병일 on 2021/11/14.
//

import UIKit

class BeerDetailViewController : UITableViewController {
  
  //MARK: - Properties
  var beer : Beer?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureNavigation()
    self.configureUI()
  }
  
  //MARK: - Functions
  private func configureNavigation() {
    title = beer?.name ?? "이름 없는 맥주"
  }
  
  private func configureUI() {
    tableView = UITableView(frame: tableView.frame, style: .insetGrouped) // insetGrouped 스타일
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerDetailListCell")
    tableView.rowHeight = UITableView.automaticDimension
    
    // 헤더뷰
    let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
    let headerView = UIImageView(frame: frame)
    let imageURL = URL(string: beer?.imageURL ?? "")
    
    headerView.contentMode = .scaleAspectFit
    headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
    
    tableView.tableHeaderView = headerView
  }
}

  //MARK: - UITableView DataSource, Delegate
extension BeerDetailViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 3 :
      return beer?.foodPairing?.count ?? 0
    default :
      return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0 :
      return "ID"
    case 1 :
      return "Description"
    case 2 :
      return "Brewers Tips"
    case 3 :
      let isFoodParingEmpty = beer?.foodPairing?.isEmpty ?? true
      return isFoodParingEmpty ? nil : "Food Pairing"
    default :
      return nil
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "BeerDetailListCell")
    cell.textLabel?.numberOfLines = 0
    cell.selectionStyle = .none
    
    switch indexPath.section {
    case 0 :
      cell.textLabel?.text = String(describing: beer?.id ?? 0)
      return cell
    case 1 :
      cell.textLabel?.text = beer?.description ?? "설명 없는 맥주"
      return cell
    case 2 :
      cell.textLabel?.text = beer?.brewersTips ?? "팁 없는 맥주"
      return cell
    case 3 :
      cell.textLabel?.text = beer?.foodPairing?[indexPath.row] ?? ""
      return cell
    default :
      return cell
    }
  }
}
