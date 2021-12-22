//
//  BlogList.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/13.
//

import UIKit
import RxSwift
import RxCocoa

class BlogListView : UITableView {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
  
//  // MainViewController -> BlogListView
//  let cellData = PublishSubject<[BlogListCellData]>()
  
  //MARK: - Init
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    attribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func bind(_ viewModel : BlogListViewModel) {
    viewModel.cellData
      .drive(self.rx.items) { tableview, row, data in
        let index = IndexPath(row: row, section: 0)
        let cell = tableview.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as! BlogListCell
        cell.setData(data)
        return cell
      }
      .disposed(by: disposeBag)
    
  }
  
  private func attribute() {
    self.backgroundColor = .white
    self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
    self.separatorStyle = .singleLine
    self.rowHeight = 100
    self.tableHeaderView = headerView
  }
}
