//
//  FavoriteViewController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

class FavoriteViewController : UIViewController {
  
  //MARK: - Properties
  
  let favoriteCollectionView : UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    title = "즐겨찾기"
    
    favoriteCollectionView.dataSource = self
    favoriteCollectionView.delegate = self
    favoriteCollectionView.backgroundColor = .white
    favoriteCollectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    view.addSubview(favoriteCollectionView)
    
    favoriteCollectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  
}

extension FavoriteViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
    return cell
  }
}

extension FavoriteViewController: UICollectionViewDelegate {
  
}


extension FavoriteViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 80)
  }
}
