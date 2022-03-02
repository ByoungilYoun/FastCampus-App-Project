//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/24.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
  func setupNavigationBar()
  func setupViews()
  func presentToReviewWriteViewController()
  func reloadTableView()
}

final class ReviewListPresenter : NSObject {
  private let viewController : ReviewListProtocol
  
  private let userDefaultsManager = UserDefaultsManager()
  
  private var review : [BookReview] = []
  
  //MARK: - Init
  init(viewController : ReviewListProtocol) {
    self.viewController = viewController
  }
  
  func viewDidLoad() {
    viewController.setupNavigationBar()
    viewController.setupViews()
  }
  
  func viewWillAppear() {
    // TODO : UserDefaults 내용 업데이트 하기
    review = userDefaultsManager.getReviews()
    viewController.reloadTableView()
  }
  
  func didTapRightBarButtonItem() {
    viewController.presentToReviewWriteViewController()
  }
}

  //MARK: - UITableViewDataSource
extension ReviewListPresenter : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return review.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    let review = review[indexPath.row]
    
    cell.textLabel?.text = review.title
    cell.detailTextLabel?.text = review.contents
    cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none, completionHandler: { _ in
      cell.setNeedsLayout() // 셀을 한번 더 레이아웃을 잡아준다.
    })
    cell.selectionStyle = .none
    return cell 
  }
}
