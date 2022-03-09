//
//  MovieListViewController.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/08.
//

import UIKit

final class MovieListViewController: UIViewController {

  //MARK: - Properties
  private lazy var presenter = MovieListPresenter(viewController: self)
  
  private let searchController = UISearchController()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

  //MARK: - MovieListProtocol
extension MovieListViewController : MovieListProtocol {
  func setupNavigationBar() {
    navigationItem.title = "영화 평점"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
  }
  
  func setupSearchBar() {
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = presenter
    navigationItem.searchController = searchController
  }
}
