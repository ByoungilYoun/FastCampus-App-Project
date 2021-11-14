//
//  HomeViewController.swift
//  NetflixStyleApp
//
//  Created by 윤병일 on 2021/11/13.
//

import UIKit

class HomeViewController : UICollectionViewController {
  
  //MARK: - Properties
  var contents : [Content] = []
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureNavigation()
    self.contents = getContents()
    
    // CollectionView Item(Cell) 설정
    collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
    collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContentCollectionViewHeader.identifier)
  }
  
  //MARK: - Functions
  private func configureNavigation() {
    // 네비게이션 설정
    navigationController?.navigationBar.backgroundColor = .clear
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.hidesBarsOnSwipe = true // 스크롤 액션이 일어났을때는 네비게이션 바를 가리는 효과
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix_icon"), style: .plain, target: nil, action: nil) // 넥플릭스 아이콘
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
  }
  
  
  func getContents() -> [Content] {
    // 데이터 설정, 가져오기
    guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
          let data = FileManager.default.contents(atPath: path),
          let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
    return list
  }
}

  //MARK: - UICollectionView DataSource, Delegate
extension HomeViewController  {
  // 섹션 개수 설정
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return contents.count // plist에 있는 root 의 각각의 아이템들이 섹션
  }
  
  // 헤더뷰 설정
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentCollectionViewHeader.identifier, for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header") }
      headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
      return headerView
    } else {
      return UICollectionReusableView()
    }
  }
  
  //섹션당 보여질 셀의 개수
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0 :
      return 1
    default :
      return contents[section].contentItem.count
    }
  }
  
  //콜렉션뷰 셀 설정
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch contents[indexPath.section].sectionType {
    case .basic, .large :
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else {return UICollectionViewCell()}
      cell.imageView.image = contents[indexPath.section].contentItem[indexPath.item].image
      return cell
    default :
      return UICollectionViewCell()
    }
  }
  
  //셀 선택
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let sectionName = contents[indexPath.section].sectionName
    print("Test : \(sectionName)의 섹션의 \(indexPath.item + 1) 번째 콘텐츠")
  }
}
