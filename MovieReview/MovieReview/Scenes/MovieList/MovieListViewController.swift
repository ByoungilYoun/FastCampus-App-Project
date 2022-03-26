//
//  MovieListViewController.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/08.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {

  //MARK: - Properties
  private lazy var presenter = MovieListPresenter(viewController: self)
  
  private let searchController = UISearchController()
  
  private lazy var collectionView : UICollectionView = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = presenter
    collectionView.dataSource = presenter
    collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    return collectionView
  }()
  
  private lazy var searchResultTableView : UITableView = {
    let tableView = UITableView()
    tableView.dataSource = presenter
    tableView.delegate = presenter
    return tableView
  }()
  
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
  
  func setupViews() {
    
    [collectionView, searchResultTableView].forEach {
      view.addSubview($0)
    }
    
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    searchResultTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    searchResultTableView.isHidden = true
  }
  
  func updateSearchTableView(isHidden : Bool) {
    searchResultTableView.isHidden = isHidden
    searchResultTableView.reloadData()
  }
  
  func pushToMovieDetailViewController(with movie : Movie) {
    let movieDetailViewController = MovieDetailViewController(movie: movie)
    navigationController?.pushViewController(movieDetailViewController, animated: true)
  }
}
