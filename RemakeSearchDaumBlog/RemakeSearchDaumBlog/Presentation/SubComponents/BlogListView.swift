//
//  BlogListView.swift
//  RemakeSearchDaumBlog
//
//  Created by 윤병일 on 2022/02/02.
//

import UIKit
import RxCocoa
import RxSwift

class BlogListView : UITableView {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
  
  // MainViewController -> BlogListView
  let cellData = PublishSubject<[BlogListCellData]>()
  
  //MARK: - Init
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    bind()
    attribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func bind() {
    // 부모뷰가 cellData 를 잘 전달했다면 어떻게 표현할지
    cellData
      .asDriver(onErrorJustReturn: [])
      .drive(self.rx.items) { tableView, row, data in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: BlogListCell.identifier, for: indexPath) as! BlogListCell
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


