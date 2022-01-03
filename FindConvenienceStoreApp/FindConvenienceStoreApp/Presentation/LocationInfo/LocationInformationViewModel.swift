//
//  LocationInformationViewModel.swift
//  FindConvenienceStoreApp
//
//  Created by 윤병일 on 2021/12/25.
//

import Foundation
import RxSwift
import RxCocoa

struct LocationInformationViewModel {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  //subViewModels
  let detailListBackgroundViewModel = DetailListBackgroundViewModel()
  
  
  // viewModel -> view
  let setMapCenter : Signal<MTMapPoint> // 센터를 잡으라는 이벤트
  let errorMessage : Signal<String>
  let detailListCellData : Driver<[DetailListCellData]>
  let scrollToSelectedLocation : Signal<Int> // 편의점을 선택했을때 테이블뷰에 표시하는것(테이블뷰의 row 값을 전달할거기 때문에 Int)
  
  // view -> viewModel
  let currentLocationButtonTapped = PublishRelay<Void>() // 현재 위치 버튼 탭
  let currentLocation = PublishRelay<MTMapPoint>()
  let mapCenterPoint = PublishRelay<MTMapPoint>()
  let selectPOIItem = PublishRelay<MTMapPOIItem>()
  let mapViewError = PublishRelay<String>()
  let detailListItemSelected = PublishRelay<Int>() // 리스트가 선택되었을때 어떠한 row 값이 전달되도록
  
  private let documentData = PublishSubject<[KLDocument]>()
  
  init(model : LocationInformationModel = LocationInformationModel()) {
    // 네트워크 통신으로 데이터 불러오기
    let cvsLocationDataResult = mapCenterPoint
      .flatMapLatest(model.getLocation)
      .share()
    
    let cvsLocationDataValue = cvsLocationDataResult
      .compactMap { data -> LocationData? in
        guard case let .success(value) = data else {
          return nil
        }
        return value
      }
    
    let cvsLocationDataErrorMessage = cvsLocationDataResult
      .compactMap { data -> String? in
        switch data {
        case let .success(data) where data.documents.isEmpty :
          return """
           500m 근처에 이용할 수 있는 편의점이 없어요.
           지도 위치를 옮겨서 재검색해주세요.
          """
        case let .failure(error) :
          return error.localizedDescription
        default :
          return nil
        }
      }
    
    cvsLocationDataValue
      .map { $0.documents }
      .bind(to: documentData)
      .disposed(by: self.disposeBag)
    
    // 지도의 중심점 설정
    let selectDetailListItem = detailListItemSelected
      .withLatestFrom(documentData) { $1[$0] }
      .map(model.documentToMTMapPoint) 
    
    let moveToCurrentLocation = currentLocationButtonTapped
      .withLatestFrom(currentLocation) // 현재위치 버튼이 currentLocation을 한번이라도 받은 이후에 작동하도록
    
    let currentMapCenter = Observable.merge (
      selectDetailListItem, // 리스트를 선택했거나
      currentLocation.take(1), // 일단 최초 현재위치를 한번 받았을때
      moveToCurrentLocation // 버튼을 눌러서 현재 위치를 이동할때
    )
    
    setMapCenter = currentMapCenter
      .asSignal(onErrorSignalWith: .empty())
    
    errorMessage = Observable
      .merge (
        cvsLocationDataErrorMessage,
        mapViewError.asObservable()
      )
      .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
    
    detailListCellData = documentData
      .map(model.documentsToCellData)
      .asDriver(onErrorDriveWith: .empty())
    
    documentData
      .map { $0.isEmpty }
      .bind(to: detailListBackgroundViewModel.shouldHideStatusLabel)
      .disposed(by: self.disposeBag)
    
    scrollToSelectedLocation = selectPOIItem
      .map { $0.tag }
      .asSignal(onErrorJustReturn: 0)
  }
}
