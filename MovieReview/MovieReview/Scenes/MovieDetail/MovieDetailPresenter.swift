//
//  MovieDetailPresenter.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/21.
//

import Foundation

protocol MovieDetailProtocol : AnyObject {
  func setupViews(with movie : Movie)
  func setRightBarButton(with isLiked : Bool) 
}

final class MovieDetailPresenter {
  
  //MARK: - Properties
  private weak var viewController : MovieDetailProtocol?
  
  private let userDefaultsManager : UserDefaultsManagerProtocol
  
  private var movie : Movie
  
  //MARK: - init
  init(viewController : MovieDetailProtocol, movie : Movie, userDefaultsManager : UserDefaultsManagerProtocol = UserDefaultManager()) {
    self.viewController = viewController
    self.movie = movie
    self.userDefaultsManager = userDefaultsManager
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController?.setupViews(with: movie)
    viewController?.setRightBarButton(with: movie.isLiked)
    print("하하 movie.isliked : \(movie.isLiked)")
  }
  
  func didTapRightBarButtonItem() {
    movie.isLiked.toggle()
    
    if movie.isLiked {
      userDefaultsManager.addMovie(movie)
    } else {
      userDefaultsManager.removeMovie(movie)
    }
    
    viewController?.setRightBarButton(with: movie.isLiked)
  }
}
