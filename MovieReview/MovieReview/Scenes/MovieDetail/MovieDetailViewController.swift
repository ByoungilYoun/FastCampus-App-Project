//
//  MovieDetailViewController.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/21.
//

import UIKit
import SnapKit

final class MovieDetailViewController : UIViewController {
  
  //MARK: - Properties
  private lazy var presenter = MovieDetailPresenter(viewController: self)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
  }
  
}

extension MovieDetailViewController : MovieDetailProtocol {
  
}
