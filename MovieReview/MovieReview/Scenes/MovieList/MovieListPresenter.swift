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
  func setupViews()
  func updateSearchTableView(isHidden : Bool)
  func pushToMovieDetailViewController(with movie : Movie)
  func updateCollectionView()
}

final class MovieListPresenter : NSObject {
  
  //MARK: - Properties
  private weak var viewController : MovieListProtocol?
  
  private let movieSearchManager : MovieSearchManagerProtocol

  private let userDefaultsManager : UserDefaultsManagerProtocol
  
  private var likedMovie : [Movie] = []
  
  private var currentMovieSearchResult : [Movie] = []
  
  //MARK: - Init
  init(viewController : MovieListProtocol, movieSearchManager : MovieSearchManagerProtocol = MovieSearchManager(), userDefaultsManager : UserDefaultsManagerProtocol = UserDefaultManager()) {
    self.viewController = viewController
    self.movieSearchManager = movieSearchManager
    self.userDefaultsManager = userDefaultsManager
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupSearchBar()
    viewController?.setupViews()
  }
  
  func viewWillAppear() {
    likedMovie = userDefaultsManager.getMovies()
    viewController?.updateCollectionView()
  }
}

  //MARK: - UISearchBarDelegate
extension MovieListPresenter : UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    viewController?.updateSearchTableView(isHidden: false)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    currentMovieSearchResult = [] // 전에 검색한거 지우기
    viewController?.updateSearchTableView(isHidden: true)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    movieSearchManager.request(from: searchText) { [weak self] movies in
      self?.currentMovieSearchResult = movies
      self?.viewController?.updateSearchTableView(isHidden: false)
    }
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension MovieListPresenter : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let spacing : CGFloat = 16.0
    let width : CGFloat = (collectionView.frame.width - spacing * 3) / 2
    return CGSize(width: width, height: 210.0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let inset : CGFloat = 16.0
    return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = likedMovie[indexPath.item]
    viewController?.pushToMovieDetailViewController(with: movie)
  }
}

  //MARK: - UICollectionViewDataSource
extension MovieListPresenter : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return likedMovie.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell
    let movie = likedMovie[indexPath.item]
    cell?.update(movie)
    return cell ?? UICollectionViewCell()
  }
}

  //MARK: - UITableViewDelegate
extension MovieListPresenter : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = currentMovieSearchResult[indexPath.row]
    viewController?.pushToMovieDetailViewController(with: movie)
  }
}

  //MARK: - UITableViewDataSource
extension MovieListPresenter : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    currentMovieSearchResult.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title
    return cell
  }
}
