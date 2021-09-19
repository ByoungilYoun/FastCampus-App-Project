//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 윤병일 on 2021/09/19.
//

import UIKit
import SnapKit
import Kingfisher

class CardListViewController : UIViewController {
  
  //MARK: - Properties
  
  let cardListTableView = UITableView()
  
  var creditCardList : [CreditCardModel] = []
  
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
    cardListTableView.register(CardListCell.self, forCellReuseIdentifier: CardListCell.identifier)
    cardListTableView.backgroundColor = .white
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
    return creditCardList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListCell.identifier, for: indexPath) as? CardListCell else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    cell.rankingLabel.text = "\(creditCardList[indexPath.row].rank)위"
    cell.moneyPayingBackLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
    cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
    
    let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
    cell.cardImageView.kf.setImage(with: imageURL)
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension CardListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}
