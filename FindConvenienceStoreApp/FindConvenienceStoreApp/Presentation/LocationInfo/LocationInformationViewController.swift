//
//  LocationInformationViewController.swift
//  FindConvenienceStoreApp
//
//  Created by 윤병일 on 2021/12/25.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import SnapKit

class LocationInformationViewController : UIViewController {
  
  //MARK: - Properties
  
  let disposeBag = DisposeBag()
  let locationManager = CLLocationManager()
  let mapView = MTMapView() // 맵뷰
  let currentLocationButton = UIButton() // 현재 위치로 가는 버튼
  let detailList = UITableView() // 상세 테이블 뷰
  let detailListBackgroundView = DetailListBackgroundView() // 편의점이 없을때 나오는 백그라운드 뷰
  let viewModel = LocationInformationViewModel()
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    locationManager.delegate = self
    
    bind(viewModel)
    attribute()
    layout()
  }
  
  //MARK: - Functions
  
  private func bind(_ viewModel : LocationInformationViewModel) {
    detailListBackgroundView.bind(viewModel.detailListBackgroundViewModel)
    
    // 맵 중앙에 오도록 bind
    viewModel.setMapCenter
      .emit(to: mapView.rx.setMapCenterPoint)
      .disposed(by: self.disposeBag)
    
    viewModel.errorMessage
      .emit(to: self.rx.presentAlert)
      .disposed(by: self.disposeBag)
    
    viewModel.detailListCellData
      .drive(detailList.rx.items) { tableview, row, data in
        let cell = tableview.dequeueReusableCell(withIdentifier: DetailListCell.identifier, for: IndexPath(row: row, section: 0)) as! DetailListCell
        cell.setData(data)
        return cell
      }.disposed(by: self.disposeBag)
    
    viewModel.detailListCellData // 맵뷰에 마커(핀)을 뿌려주기 위해
      .map { $0.compactMap {$0.point} }
      .drive(self.rx.addPOIItems)
      .disposed(by: self.disposeBag)
    
    viewModel.scrollToSelectedLocation
      .emit(to: self.rx.showSelectedLocation)
      .disposed(by: self.disposeBag)
    
    detailList.rx.itemSelected
      .map { $0.row }
      .bind(to: viewModel.detailListItemSelected)
      .disposed(by: self.disposeBag)
    
    currentLocationButton.rx.tap
      .bind(to: viewModel.currentLocationButtonTapped)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    title = "내 주변 편의점 찾기"
    view.backgroundColor = .white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black] // 네비 타이틀 색 변경
    
    mapView.currentLocationTrackingMode = .onWithHeadingWithoutMapMoving
    
    currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    currentLocationButton.backgroundColor = .white
    currentLocationButton.layer.cornerRadius = 20
    
    detailList.register(DetailListCell.self, forCellReuseIdentifier: DetailListCell.identifier)
    detailList.separatorStyle = .none
    detailList.backgroundView = detailListBackgroundView
  }
  
  private func layout() {
    [mapView, currentLocationButton, detailList].forEach {
      view.addSubview($0)
    }
    
    mapView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalTo(view.snp.centerY).offset(100)
    }
    
    currentLocationButton.snp.makeConstraints {
      $0.bottom.equalTo(detailList.snp.top).offset(-12)
      $0.leading.equalToSuperview().offset(12)
      $0.width.height.equalTo(40)
    }
    
    detailList.snp.makeConstraints {
      $0.centerX.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
      $0.top.equalTo(mapView.snp.bottom)
    }
  }
}

  //MARK: - extension CLLocationManagerDelegate
extension LocationInformationViewController : CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways,
        .authorizedWhenInUse,
        .notDetermined :
      return
    default :
      viewModel.mapViewError.accept(MTMapViewError.locationAuthorizationDenied.errorDescription) // 그렇지 않으면 에러처리
      return
    }
  }
}

  //MARK: - extension MTMapViewDelegate
extension LocationInformationViewController : MTMapViewDelegate {
  func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
    #if DEBUG // 디버그일때
    viewModel.currentLocation.accept(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.394225, longitude: 127.110341)))
    #else // 디버그 아닐때
    viewModel.currentLocation.accept(location)
    #endif
  } //  현재 위치를 매번 업데이트 해주는 함수
  
  func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) { // 맵의 이동이 끝났을때 마지막의 센터 포인트를 전달해주는 함수
    viewModel.mapCenterPoint.accept(mapCenterPoint)
  }
  
  func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool { // 핀 표시 아이템을 탭할때마다 아이템의 mtMapPoint를 전달해주는 함수
    viewModel.selectPOIItem.accept(poiItem)
    return false
  }
  
  func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) { // 제대로된 현재위치를 불러오지 못했을때 에러를 내뱉는 델리게이트 함수
    viewModel.mapViewError.accept(error.localizedDescription)
  }
}

extension Reactive where Base : MTMapView {
  var setMapCenterPoint : Binder<MTMapPoint> {
    return Binder(base) { base, point in
      base.setMapCenter(point, animated: true)
    }
  }
}

extension Reactive where Base : LocationInformationViewController {
  var presentAlert : Binder<String> {
    return Binder(base) { base, message in
      let alertController = UIAlertController(title: "문제가 발생했어요.", message: message, preferredStyle: .alert)
      let action = UIAlertAction(title: "확인", style: .default, handler: nil)
      alertController.addAction(action)
      base.present(alertController, animated: true, completion: nil)
    }
  }
  
  var showSelectedLocation : Binder<Int> { // 마크 클릭하면 테이블뷰 상단에 오도록 커스텀 설정
    return Binder(base) { base, row in
      let indexPath = IndexPath(row: row, section: 0)
      base.detailList.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
  }
  
  var addPOIItems : Binder<[MTMapPoint]> {
    return Binder(base) { base, points in
      let items = points
        .enumerated()
        .map { offset, point -> MTMapPOIItem in
          let mapPOIItem = MTMapPOIItem()
          mapPOIItem.mapPoint = point // 지도상 좌표
          mapPOIItem.markerType = .redPin
          mapPOIItem.showAnimationType = .springFromGround
          mapPOIItem.tag = offset // 고유한 tag 를 가질수 있도록
          return mapPOIItem
        }
      
      base.mapView.removeAllPOIItems() // 매번 새로운 어떤 이벤트를 받을때마다 기존에 가지고 있던 아이템을 다 지우고
      base.mapView.addPOIItems(items) // POIitem 을 새로 넣어준다.
    }
  }
}
