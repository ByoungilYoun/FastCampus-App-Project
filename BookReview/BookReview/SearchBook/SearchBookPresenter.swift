//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 윤병일 on 2022/03/01.
//

import UIKit

protocol SearchBookProtocol {
  func setupViews()
  func dismiss()
  func reloadView()
}

protocol SearchBookDelegate {
  func selectBook(_ book : Book)
}

final class SearchBookPresenter : NSObject {
  
  //MARK: - Properties
  private let viewController : SearchBookProtocol
  
  private let bookSearchManager = BookSearchManager()
  
  private var books : [Book] = []
  
  private let delegate : SearchBookDelegate
  
  //MARK: - init
  init(viewController : SearchBookProtocol, delegate : SearchBookDelegate) {
    self.viewController = viewController
    self.delegate = delegate
  }
  
  //MARK: - Functions
  func viewDidLoad() {
    viewController.setupViews()
  }
}

  //MARK: - UISearchBarDelegate
extension SearchBookPresenter : UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    
    bookSearchManager.request(from: searchText) { [weak self] newBooks in
      self?.books = newBooks
      self?.viewController.reloadView()
    }
  }
}

  //MARK: - UITableViewDelegate
extension SearchBookPresenter : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedBook = books[indexPath.row]
    delegate.selectBook(selectedBook)
    
    viewController.dismiss()
  }
}

  //MARK: - UITableViewDataSource
extension SearchBookPresenter : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    books.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = books[indexPath.row].title
    return cell
  }
}
