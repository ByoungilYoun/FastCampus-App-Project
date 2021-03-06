//
//  LocationInformationViewModel.swift
//  RemakeFindCVS
//
//  Created by 윤병일 on 2022/02/16.
//

import RxSwift
import RxCocoa

struct LocationInformationViewModel {

  //MARK: - Properties 
  let disposeBag = DisposeBag()
  
  // subViewModels
  let detailListBackgroundViewModel = DetailListBackgroundViewModel()
  
  // viewModel -> view
  let setMapCenter : Signal<MTMapPoint>
  let errorMessage : Signal<String>
  
  let detailListCellData : Driver<[DetailListCellData]>
  let scrollToSelectedLocation : Signal<Int>
  
  // view -> viewModel
  let currentLocation = PublishRelay<MTMapPoint>()
  let mapCenterPoint = PublishRelay<MTMapPoint>()
  let selectPOIItem = PublishRelay<MTMapPOIItem>()
  let mapViewError = PublishRelay<String>()
  
  let currentLocationButtonTapped = PublishRelay<Void>()
  
  let detailListItemSelected = PublishRelay<Int>()
  
  let documentData = PublishSubject<[KLDocument?]>()
  
  init() {
    // 지도 중심점 설정
    
    let selectDetailListItem = detailListItemSelected
      .withLatestFrom(documentData) {
        $1[$0]
      }.map {
        data -> MTMapPoint in
          guard let data = data,
                let longitude = Double(data.x),
                let latitude = Double(data.y) else {
                  return MTMapPoint()
                }
        
        let geoCord = MTMapPointGeo(latitude: latitude, longitude: longitude)
        return MTMapPoint(geoCoord: geoCord)
      }
    
    let moveToCurrentLocation = currentLocationButtonTapped
      .withLatestFrom(currentLocation)
    
    let currentMapCenter = Observable
      .merge(
        selectDetailListItem,
        currentLocation.take(1),
        moveToCurrentLocation
      )
    
    setMapCenter = currentMapCenter
      .asSignal(onErrorSignalWith: .empty())
    
    errorMessage = mapViewError.asObservable()
      .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
    
    detailListCellData = Driver.just([])
    
    scrollToSelectedLocation = selectPOIItem
      .map { $0.tag }
      .asSignal(onErrorJustReturn: 0)
  }
}
