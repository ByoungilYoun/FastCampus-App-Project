//
//  BlogListView.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/09.
//

import UIKit
import RxSwift
import RxCocoa

class BlogListView : UITableView {
  
  //MARK: - Properties
  
  private let disposeBag = DisposeBag()
  
  let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
  
  // MainViewController 에서 네트워크 작업을 해서 받아온 값을 BlogListView 로 받아올 이벤트
  let cellData = PublishSubject<[BlogListCellData]>()
  
  //MARK: - Init
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    self.bind()
    self.attribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  //MARK: - Functions
  private func bind() {
    cellData
      .asDriver(onErrorJustReturn: [])
      .drive(self.rx.items) { tableview, row, data in
        let index = IndexPath(row: row, section: 0)
        let cell = tableview.dequeueReusableCell(withIdentifier: BlogListCell.identifier, for : index) as! BlogListCell
        cell.setData(data)
        return cell
      }.disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    self.backgroundColor = .white
    self.register(BlogListCell.self, forCellReuseIdentifier: BlogListCell.identifier)
    self.separatorStyle = .singleLine
    self.rowHeight = 100
    self.tableHeaderView = headerView
  }
}


