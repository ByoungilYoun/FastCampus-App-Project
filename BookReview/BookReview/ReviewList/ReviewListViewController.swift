//
//  ReviewListViewController.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/24.
//

import UIKit

class ReviewListViewController : UIViewController {
  
  //MARK: - Properties
  private lazy var presenter = ReviewListPresenter(viewController: self)
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    presenter.print()
  }
  
  //MARK: - Functions
  private func configureUI() {
    
  }
  
  //MARK: - @objc func
  
}

extension ReviewListViewController : ReviewListProtocol {
  
}
