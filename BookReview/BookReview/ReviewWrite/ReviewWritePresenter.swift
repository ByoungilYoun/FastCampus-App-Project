//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/28.
//

import Foundation

protocol ReviewWriteProtocol {
  func setupNavigationBar()
  func showCloseAlertController()
  func close()
  func setupViews()
  func presentToSearchBookViewController()
  func updateViews(title : String, imageUrl : URL?)
}

final class ReviewWritePresenter {

  //MARK: - Properties
  private let viewController : ReviewWriteProtocol
  
  //MARK: - init
  
  init(viewController : ReviewWriteProtocol) {
    self.viewController = viewController
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController.setupNavigationBar()
    viewController.setupViews()
  }
  
  func didTapLeftBarButton() {
    viewController.showCloseAlertController()
  }
  
  func didTapRightBarButton() {
    // TODO : UserDefaults 에 유저가 저장한 도서리뷰를 저장하기
    viewController.close()
  }
  
  func didTapBookTitleButton() {
    viewController.presentToSearchBookViewController()
  }
}

extension ReviewWritePresenter : SearchBookDelegate {
  func selectBook(_ book: Book) {
    viewController.updateViews(title: book.title, imageUrl: book.imageURL)
  }
}
