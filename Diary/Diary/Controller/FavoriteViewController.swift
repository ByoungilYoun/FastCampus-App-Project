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
  
  private var diaryList = [Diary]()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    self.loadStarDiaryList()
    
    // 수정이 일어났을때
    NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
    
    // 스타 토글이 일어났을때
    NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: NSNotification.Name("starDiary"), object: nil)
    
    // 삭제가 일어났을 때
    NotificationCenter.default.addObserver(self, selector: #selector(deleteDiaryNotification(_:)), name: NSNotification.Name("deleteDiary"), object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  
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
  
  private func loadStarDiaryList() {
    let userDefaults = UserDefaults.standard
    guard let data = userDefaults.object(forKey: "diaryList") as? [[String : Any]] else {return}
    
    self.diaryList = data.compactMap {
      guard let title = $0["title"] as? String else {return nil }
      guard let contents = $0["contents"] as? String else { return nil }
      guard let date = $0["date"] as? Date else { return nil }
      guard let isStar = $0["isStar"] as? Bool else {return nil }
      return Diary(title: title, contents: contents, date: date, isStar: isStar)
    }.filter({
      $0.isStar == true // 즐겨찾기가 된 것들만 가져오기
    }).sorted(by: {
      $0.date.compare($1.date) == .orderedDescending
    })
  }
  
  private func dateToString(date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
  }
  
  //MARK: - @objc func
  @objc func editDiaryNotification(_ notification : Notification) {
    guard let diary = notification.object as? Diary else {return}
    guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
    self.diaryList[row] = diary
    self.diaryList = self.diaryList.sorted(by: {
      $0.date.compare($1.date) == .orderedDescending
    })
    
    self.favoriteCollectionView.reloadData()
  }
  
  @objc func starDiaryNotification(_ notification : Notification) {
    guard let starDiary = notification.object as? [String : Any] else {return}
    guard let isStar = starDiary["isStar"] as? Bool else {return}
    guard let indexPath = starDiary["indexPath"] as? IndexPath else { return }
    guard let diary = starDiary["diary"] as? Diary else {return}
    
    if isStar {
      self.diaryList.append(diary)
      self.diaryList = self.diaryList.sorted(by: {
        $0.date.compare($1.date) == .orderedDescending
      })
      self.favoriteCollectionView.reloadData()
    } else {
      self.diaryList.remove(at: indexPath.row)
      self.favoriteCollectionView.deleteItems(at: [indexPath])
    }
  }
  
  @objc func deleteDiaryNotification(_ notification : Notification) {
    guard let indexPath = notification.object as? IndexPath else {return}
    self.diaryList.remove(at: indexPath.row)
    self.favoriteCollectionView.deleteItems(at: [indexPath])
  }
}

extension FavoriteViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.diaryList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell else {return UICollectionViewCell()}
    let diary = self.diaryList[indexPath.row]
    cell.titleLabel.text = diary.title
    cell.dateLabel.text = self.dateToString(date: diary.date)
    return cell
  }
}

extension FavoriteViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = DetailDiaryViewController()
    let diary = self.diaryList[indexPath.row]
    vc.diary = diary
    vc.indexPath = indexPath
    self.navigationController?.pushViewController(vc, animated: true)
  }
}


extension FavoriteViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}
