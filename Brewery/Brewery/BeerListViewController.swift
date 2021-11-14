//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 윤병일 on 2021/11/14.
//

import UIKit

class BeerListViewController : UITableViewController {

  var beerList = [Beer]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavigation()
  }
  
  //MARK: - Functions
  private func configureNavigation() {
    title = "패캠브루어리"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureUI() {
    view.backgroundColor = .white
    
    //UITableView 설정
    tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
    tableView.rowHeight = 150
    
  }
}


  //MARK: - extension UITableView Datasource, Delegate
extension BeerListViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return beerList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell()}
    let beer = beerList[indexPath.row]
    cell.configure(with: beer)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedBeer = beerList[indexPath.row]
    let detailViewController = BeerDetailViewController()
    detailViewController.beer = selectedBeer
    self.show(detailViewController, sender: nil)
  }
}
