//
//  MainViewController.swift
//  RemakeSearchDaumBlog
//
//  Created by 윤병일 on 2022/01/30.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController : UIViewController {
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  // searchBar
  // listView
  
  
  //MARK: - Init
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    bind()
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func bind() {
    
  }
  
  private func attribute() {
    title = "다음 블로그 검색"
    view.backgroundColor = .white
  }
  
  private func layout() {
    
  }
  
  
}
