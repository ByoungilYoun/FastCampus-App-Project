//
//  MovieDetailPresenter.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/21.
//

import Foundation

protocol MovieDetailProtocol : AnyObject {
  
}

final class MovieDetailPresenter {
  
  //MARK: - Properties
  private weak var viewController : MovieDetailProtocol?
  
  private var movie : Movie
  
  //MARK: - init
  init(viewController : MovieDetailProtocol, movie : Movie) {
    self.viewController = viewController
    self.movie = movie
  }
  
  
}
