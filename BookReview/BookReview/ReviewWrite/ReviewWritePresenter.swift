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
  
  private let userDefaultManager : UserDefaultsManagerProtocol

  var book : Book?
  
  let contentsTextViewPlaceHolderText = "내용을 입력해주세요."
  
  //MARK: - init
  
  init(viewController : ReviewWriteProtocol, userDefaultsManager : UserDefaultsManagerProtocol = UserDefaultsManager()) {
    self.viewController = viewController
    self.userDefaultManager = userDefaultsManager
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController.setupNavigationBar()
    viewController.setupViews()
  }
  
  func didTapLeftBarButton() {
    viewController.showCloseAlertController()
  }
  
  func didTapRightBarButton(contentsText : String?) {
    guard let book = book,
          let contentsText = contentsText,
          contentsText != contentsTextViewPlaceHolderText
    else { return }

    let bookReview = BookReview(title: book.title, contents: contentsText, imageURL: book.imageURL)
    userDefaultManager.setReview(bookReview)
    
    viewController.close()
  }
  
  func didTapBookTitleButton() {
    viewController.presentToSearchBookViewController()
  }
}

extension ReviewWritePresenter : SearchBookDelegate {
  func selectBook(_ book: Book) {
    self.book = book
    viewController.updateViews(title: book.title, imageUrl: book.imageURL)
  }
}
