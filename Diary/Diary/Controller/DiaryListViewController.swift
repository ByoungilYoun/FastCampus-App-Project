//
//  DiaryListViewController.swift
//  Diary
//
//  Created by 윤병일 on 2021/10/06.
//

import UIKit

class DiaryListViewController : UIViewController {
  
  //MARK: - Properties
  
  let diaryListCollectionView : UICollectionView = {
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
    title = "일기장"
    
    diaryListCollectionView.dataSource = self
    diaryListCollectionView.delegate = self
    diaryListCollectionView.backgroundColor = .white
    diaryListCollectionView.register(DiaryListCollectionViewCell.self, forCellWithReuseIdentifier: DiaryListCollectionViewCell.identifier)
    view.addSubview(diaryListCollectionView)
    
    diaryListCollectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  
}

extension DiaryListViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryListCollectionViewCell.identifier, for: indexPath) as! DiaryListCollectionViewCell
    return cell
  }
}

extension DiaryListViewController : UICollectionViewDelegate {
  
}


extension DiaryListViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width / 2
    return CGSize(width: width, height: width)
  }
}
