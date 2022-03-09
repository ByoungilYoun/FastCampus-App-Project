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
}

final class MovieListPresenter : NSObject {
  
  //MARK: - Properties
  private weak var viewController : MovieListProtocol?

  private var likedMovie : [Movie] = [
    Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "haha", director: "asdf", pubDate: "2022"),
    Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "haha", director: "asdf", pubDate: "2022"),
    Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "haha", director: "asdf", pubDate: "2022")
  ]
  
  //MARK: - Init
  init(viewController : MovieListProtocol) {
    self.viewController = viewController
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupSearchBar()
    viewController?.setupViews()
  }
}

  //MARK: - UISearchBarDelegate
extension MovieListPresenter : UISearchBarDelegate {
  
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
