//
//  MovieListPresenter.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/09.
//

import UIKit

protocol MovieListProtocol : AnyObject {
  func setupNavigationBar()
  func setupSearchBar()
}

final class MovieListPresenter : NSObject {
  
  //MARK: - Properties
  private weak var viewController : MovieListProtocol?
  
  //MARK: - Init
  init(viewController : MovieListProtocol) {
    self.viewController = viewController
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupSearchBar()
  }
}

  //MARK: - UISearchBarDelegate
extension MovieListPresenter : UISearchBarDelegate {
  
}
