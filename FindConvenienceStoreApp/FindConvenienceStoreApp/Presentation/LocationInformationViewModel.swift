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
  
  // viewModel -> view
  let setMapCenter : Signal<MTMapPoint> // 센터를 잡으라는 이벤트
  let errorMessage : Signal<String>
  
  // view -> viewModel
  let currentLocationButtonTapped = PublishRelay<Void>() // 현재 위치 버튼 탭
  let currentLocation = PublishRelay<MTMapPoint>()
  let mapCenterPoint = PublishRelay<MTMapPoint>()
  let selectPOIItem = PublishRelay<MTMapPOIItem>()
  let mapViewError = PublishRelay<String>()
  
  init() {
    // 지도의 중심점 설정
    let moveToCurrentLocation = currentLocationButtonTapped
      .withLatestFrom(currentLocation) // 현재위치 버튼이 currentLocation을 한번이라도 받은 이후에 작동하도록
    
    let currentMapCenter = Observable.merge (
      currentLocation.take(1), // 일단 최초 현재위치를 한번 받았을때
      moveToCurrentLocation
    )
    
    setMapCenter = currentMapCenter
      .asSignal(onErrorSignalWith: .empty())
    
    errorMessage = mapViewError.asObservable()
      .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
  }
}
