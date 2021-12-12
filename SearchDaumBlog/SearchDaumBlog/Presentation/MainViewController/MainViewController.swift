//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/13.
//

import RxSwift
import RxCocoa
import UIKit

class MainViewController : UIViewController {
  
  //MARK: - Properties
  
  let disposeBag = DisposeBag()
  
  // listView
  // searchBar
  
  //MARK: - init
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
  private func configureUI() {
    
  }
  
  private func bind() {
    
  }
  
  private func attribute() {
    title = "다음 블로그 검색"
    view.backgroundColor = .white
  }
  
  private func layout() {
    
  }
}
