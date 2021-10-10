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
  
  private var diaryList = [Diary]()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    title = "일기장"
    
    let rightTabButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBtnTapped))
    navigationItem.rightBarButtonItem = rightTabButton
    
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
  
  private func dateToString(date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
  }
  
  //MARK: - @objc func
  @objc func plusBtnTapped() {
    let controller = RegisterDiaryViewController()
    controller.delegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
}

extension DiaryListViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.diaryList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryListCollectionViewCell.identifier, for: indexPath) as? DiaryListCollectionViewCell else { return UICollectionViewCell() }
    let diary = self.diaryList[indexPath.row]
    cell.titleLabel.text = diary.title
    cell.dateLabel.text = self.dateToString(date: diary.date)
    return cell
  }
}

  //MARK: - UICollectionViewDelegate
extension DiaryListViewController : UICollectionViewDelegate {
  
}


  //MARK: - UICollectionViewDelegateFlowLayout
extension DiaryListViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (UIScreen.main.bounds.width / 2 ) - 20
    return CGSize(width: width, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}

//MARK: - RegisterDiaryViewControllerDelegate
extension DiaryListViewController : RegisterDiaryViewControllerDelegate {
  func didSelectRegister(diary: Diary) {
    self.diaryList.append(diary)
    self.diaryListCollectionView.reloadData()
  }
}
