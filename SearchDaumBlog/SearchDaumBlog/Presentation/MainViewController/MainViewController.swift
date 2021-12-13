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
  
  let searchBar = SearchBar()
  let listView = BlogListView()
  
  let alertActionTapped = PublishRelay<AlertAction>()
  
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
  
  private func bind() {
    let blogResult = searchBar.shouldLoadResult
      .flatMapLatest { query in
        SearchBlogNetwork().searchBlog(query: query)
      }
      .share()
    
    let blogValue = blogResult // 성공한 데이터 값
      .compactMap { data -> DaumKakaoBlog? in
        guard case .success(let value) = data else {
          return nil
        }
        
        return value
      }
    
    let blogError = blogResult // 에러
      .compactMap { data -> String? in
        guard case .failure(let error) = data else {
          return nil
        }
        return error.localizedDescription
      }
    
    // 네트워크를 통해 가져온 값을 cellData 로 변환
    let cellData = blogValue
      .map { blog -> [BlogListCellData] in
        return blog.documents
          .map { doc in
            let thumbnailURL = URL(string: doc.thumbnail ?? "")
            return BlogListCellData(thumbnailURL: thumbnailURL, name: doc.name, title: doc.title, dateTime: doc.datetime)
          }
      }
    
    // FilterView 를 선택했을 때 나오는 alertSheet 를 선택했을때 type
    let sortedType = alertActionTapped
      .filter {
        switch $0 {
        case .title, .datetime :
          return true
        default :
          return false
        }
      }
      .startWith(.title) // 만약 아무도 필터를 건들지 않으면 맨 처음 테이블뷰에 나오는 기준은 title 로 설정
    
    // MainViewController 에서 ListView 로 전달
    Observable
      .combineLatest(sortedType, cellData) { type, data -> [BlogListCellData] in 
        switch type {
        case .title :
          return data.sorted { $0.title ?? "" < $1.title ?? "" }
        case .datetime :
          return data.sorted { $0.dateTime ?? Date() > $1.dateTime ?? Date() }
        default :
          return data
        }
      }
      .bind(to: listView.cellData)
      .disposed(by: disposeBag)
    
    
    let alertSheetForSorting = listView.headerView.sortButtonTapped
      .map { _ -> Alert in
        return (title : nil, message : nil, actions : [.title, .datetime, .cancel], style : .actionSheet)
      }
    
    let alertForErrorMessage = blogError
      .map { message -> Alert in
        return (title : "앗!", message : "예상치 못한 오류가 발생했어요 \(message)", actions : [.confirm], style : .alert)
      }
    
    
    Observable
      .merge(
        alertSheetForSorting,
        alertForErrorMessage
      )
      .asSignal(onErrorSignalWith: .empty())
      .flatMapLatest { alert -> Signal<AlertAction> in
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
        return self.presentAlertController(alertController, actions: alert.actions)
      }
      .emit(to: alertActionTapped)
      .disposed(by: disposeBag)
  }
  
  private func attribute() {
    title = "다음 블로그 검색"
    view.backgroundColor = .white
  }
  
  private func layout() {
    [searchBar, listView].forEach {
      view.addSubview($0)
    }
    

    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    
    listView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

 //MARK: - Alert
extension MainViewController {
  typealias Alert = (title : String?, message : String?, actions : [AlertAction], style : UIAlertController.Style)
  
  enum AlertAction : AlertActionConvertable {
    case title, datetime, cancel
    case confirm
    
    var title : String {
      switch self {
      case .title :
        return "Title"
      case .datetime :
        return "Datetime"
      case .cancel :
        return "취소"
      case .confirm :
        return "확인"
      }
    }
    
    var style : UIAlertAction.Style {
      switch self {
      case .title, .datetime :
        return .default
      case .cancel, .confirm :
        return .cancel
      }
    }
  }
  
  func presentAlertController<Action : AlertActionConvertable>(_ alertController : UIAlertController, actions : [Action]) -> Signal<Action> {
    if actions.isEmpty { return .empty() }
    return Observable.create { [weak self] observer in
      guard let self = self else {return Disposables.create()}
      
      for action in actions {
        alertController.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
          observer.onNext(action)
          observer.onCompleted()
        }))
      }
      self.present(alertController, animated: true, completion: nil)
      return Disposables.create {
        alertController.dismiss(animated: true, completion: nil)
      }
    }
    .asSignal(onErrorSignalWith: .empty())
  }
}
