//
//  BookmarkListViewController.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import UIKit

final class BookmarkListViewController : UIViewController {
  
  //MARK: - Properties
  
  private var bookmark : [Bookmark] = []
  
  private lazy var collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    
    let inset : CGFloat = 16.0
    layout.estimatedItemSize = CGSize(width: view.frame.width - 32, height: 100.0)
    layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    layout.minimumLineSpacing = 16.0
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.dataSource = self
    collectionView.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
    return collectionView
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    bookmark = UserDefaults.standard.bookmarks
    collectionView.reloadData()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .secondarySystemBackground
    
    navigationItem.title = "즐겨찾기"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  
}

  //MARK: - extension UICollectionViewDataSource
extension BookmarkListViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return bookmark.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier, for: indexPath) as? BookmarkCollectionViewCell else { return UICollectionViewCell() }
    cell.configureUI(from: bookmark[indexPath.item])
    return cell
  }
}
