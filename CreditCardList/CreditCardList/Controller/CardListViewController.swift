//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 윤병일 on 2021/09/19.
//

import UIKit
import SnapKit
import Kingfisher
import FirebaseDatabase

class CardListViewController : UIViewController {
  
  //MARK: - Properties
  
  var ref : DatabaseReference! // Firebae Realtime Database (루트 레퍼런스)
  
  let cardListTableView = UITableView()
  
  var creditCardList : [CreditCardModel] = []
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    getCardListData()
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
  
  private func getCardListData() {
    ref = Database.database().reference()
    ref.observe(.value) { snapshot in
      guard let value = snapshot.value as? [String : [String : Any]] else {return}
      
      do {
        let jsonData = try JSONSerialization.data(withJSONObject: value)
        let cardData = try JSONDecoder().decode([String : CreditCardModel].self, from: jsonData)
        let cardList = Array(cardData.values)
        
        self.creditCardList = cardList.sorted {
          $0.rank < $1.rank
        }
        
        DispatchQueue.main.async {
          self.cardListTableView.reloadData() // 리로드는 메인쓰레드에서 해줘야한다.
        }
        
      } catch let error {
        print("Error JSON Parsing : \(error.localizedDescription)")
      }
    }
  }
  
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = CardDetailViewController()
    vc.promotionDetail = creditCardList[indexPath.row].promotionDetail
    navigationController?.pushViewController(vc, animated: true)
    
    // Option 1 경로를 알고있을때
    let cardID = creditCardList[indexPath.row].id
    ref.child("Item\(cardID)/isSelected").setValue(true) // 실시간으로 클릭시 item 의 isSelected 에 true 값을 넣음
    
    // Option 2 경로를 모를때, 키 값이 불분명할때
//    ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//      guard let self = self ,
//            let value = snapshot.value as? [String : [String:Any]],
//            let key = value.keys.first else {return}
//
//      self.ref.child("\(key)/isSelected").setValue(true)
//    }
  }
  
  // 옆으로 밀었을때 삭제 할 수 있는 델리게이트 함수
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // 삭제
      // Option 1 경로를 알고있을때
      let cardID = creditCardList[indexPath.row].id
      ref.child("Item\(cardID)").removeValue()
      
      
      // Option 2
//      ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//        guard let self = self,
//              let value = snapshot.value as? [String : [String : Any]],
//              let key = value.keys.first else {return}
//
//        ref.child(key).removeValue()
//      }
    }
  }
}
