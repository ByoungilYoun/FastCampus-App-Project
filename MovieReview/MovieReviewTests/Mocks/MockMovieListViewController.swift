//
//  MockMovieListViewController.swift
//  MovieReviewTests
//
//  Created by 윤병일 on 2022/03/28.
//

import Foundation
@testable import MovieReview

final class MockMovieListViewController : MovieListProtocol {
  var isCalledSetupNavigationBar = false
  var isCalledSetupSearchBar = false
  var isCalledSetupViews = false
  var isCalledUpdateSearchTableView = false
  var isCalledPushToMovieDetailViewController = false
  var isCalledUpdateCollectionView = false
  
  func setupNavigationBar() {
    isCalledSetupNavigationBar = true
  }
  
  func setupSearchBar() {
    isCalledSetupSearchBar = true
  }
  
  func setupViews() {
    isCalledSetupViews = true
  }
  
  func updateSearchTableView(isHidden: Bool) {
    isCalledUpdateSearchTableView = true
  }
  
  func pushToMovieDetailViewController(with movie: Movie) {
    isCalledPushToMovieDetailViewController = true
  }
  
  func updateCollectionView() {
    isCalledUpdateCollectionView = true
  }
}
