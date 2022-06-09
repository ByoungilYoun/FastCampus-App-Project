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
  
  let searchBar = SearchBar()
  let listView = BlogListView()
  let alertActionTapped = PublishRelay<AlertAction>()
  
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
    
    let blogResult = searchBar.shouldLoadResult
      .flatMapLatest { query in
        SearchBlogNetwork().searchBlog(query: query)
      }
      .share() // 스트림 공유
    
    // blogResult 에서 성공한값 (데이터)
    let blogValue = blogResult
      .compactMap { data -> DKBlog? in
        guard case .success(let value) = data else {
          return nil
        }
        
        return value
      }
    
    // blogResult 에서 실패한값 (에러)
    let blogError = blogResult
      .compactMap { data -> String? in
        guard case .failure(let error) = data else {
          return nil
        }
        return error.localizedDescription
      }
    
    let alertForErrorMessage = blogError
      .map { message -> Alert in
        return (title : "앗!", message : "예상치 못한 오류 발생 \(message)", actions : [.confirm], style : .alert)
      }
    
  
    // 네트워크를 통해 가져온 값을 cellData 로 변환
    let cellData = blogValue
      .map { blog -> [BlogListCellData] in
        return blog.documents
          .map { doc in
            let thumbnailURL = URL(string: doc.thumbnail ?? "")
            return BlogListCellData(thumbnailURL: thumbnailURL, name: doc.name, title: doc.title, datetime: doc.datetime)
          }
      }
    
    // FilterView  를 선택했을때 나오는 alertSheet 를 선택했을 때 type
    let sortedType = alertActionTapped
      .filter {
        switch $0 {
        case .title, .datetime :
          return true
        default :
          return false
        }
      }
      .startWith(.title)
    
    // MainViewController -> BlogListView 의 셀 데이터로 전달
    Observable
      .combineLatest(sortedType, cellData) { type, data -> [BlogListCellData] in
        switch type {
        case .title :
          return data.sorted { $0.title ?? "" < $1.title ?? "" }
        case .datetime :
          return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
        default :
          return data
        }
      }.bind(to: listView.cellData)
      .disposed(by: self.disposeBag)
    
    
    let alertSheetForSorting = listView.headerView.sortButtonTapped
      .map { _ -> Alert in
        return (title : nil, message : nil, actions : [.title, .datetime, .cancel], style : .actionSheet)
      }
    
    Observable
      .merge(
        alertSheetForSorting, // 필터 눌렀을때 alert 창 나올때
        alertForErrorMessage // 에러 메세지가 있을때 alert 창 나올때
      )
      .asSignal(onErrorSignalWith: .empty())
      .flatMapLatest { alert -> Signal<AlertAction> in
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
        return self.presentAlertController(alertController, actions: alert.actions)
      }
      .emit(to: alertActionTapped)
      .disposed(by: self.disposeBag)
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

extension MainViewController {
  typealias Alert = (title : String?, message : String?, actions : [AlertAction], style : UIAlertController.Style)
  
  enum AlertAction : AlertActionConvertable {
    case title, datetime, cancel
    case confirm
    
    var title: String {
      switch self {
      case .title : return "Title"
      case .datetime : return "DateTime"
      case .cancel : return "취소"
      case .confirm : return "확인"
      }
    }
    
    var style: UIAlertAction.Style {
      switch self {
      case .title, .datetime : return .default
      case .cancel, .confirm : return .cancel
      }
    }
  }
  
  func presentAlertController<Action : AlertActionConvertable>(_ alertController : UIAlertController, actions : [Action]) -> Signal<Action> {
    if actions.isEmpty {
      return .empty()
    }
    
    return Observable.create { [weak self] observer in
      guard let self = self else { return Disposables.create() }
      for action in actions {
        alertController.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
          observer.onNext(action)
          observer.onCompleted()
        }))
      }
      
      self.present(alertController, animated : true, completion : nil)
      return Disposables.create {
        alertController.dismiss(animated: true, completion: nil)
      }
    }
    .asSignal(onErrorSignalWith: .empty())
  }
}
