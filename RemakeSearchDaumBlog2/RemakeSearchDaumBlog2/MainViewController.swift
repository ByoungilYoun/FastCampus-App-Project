//
//  MainViewController.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/07.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController : UIViewController {
  
  //MARK: - Properties
  
  private let disposeBag = DisposeBag()
  
  // let listView
  // let searchBar
  
  //MARK: - Init
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.bind()
    self.attribute()
    self.layout()
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
  
  //MARK: - @objc func
  
}
