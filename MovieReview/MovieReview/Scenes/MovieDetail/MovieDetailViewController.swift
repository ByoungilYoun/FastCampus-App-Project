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
  private var presenter : MovieDetailPresenter!
  
  
  //MARK: - Init
  init(movie : Movie) {
    super.init(nibName: nil, bundle: nil)
    self.presenter = MovieDetailPresenter(viewController: self, movie: movie)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

  //MARK: - MovieDetailProtocol
extension MovieDetailViewController : MovieDetailProtocol {
  
}
