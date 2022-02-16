//
//  LocationInformationViewController.swift
//  RemakeFindCVS
//
//  Created by 윤병일 on 2022/02/16.
//

import UIKit
import CoreLocation
import SnapKit
import RxSwift
import RxCocoa

class LocationInformationViewController : UIViewController {
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  
  let locationManager = CLLocationManager()
  
  let mapView = MTMapView()
  
  let detailList = UITableView()
  
  let currentLocationButton = UIButton()
  
  let viewModel = LocationInformationViewModel()
  
  //MARK: - Lifecycle
  
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
    viewModel.setMapCenter
      .emit(to: mapView.rx.setMapCenterPoint)
      .disposed(by: self.disposeBag)
    
    viewModel.errorMessage
      .emit(to: self.rx.presentAlert)
      .disposed(by: self.disposeBag)
    
    
    currentLocationButton.rx.tap
      .bind(to: viewModel.currentLocationButtonTapped)
      .disposed(by: self.disposeBag)
  }
  
  private func attribute() {
    title = "내 주변 편의점 찾기"
    view.backgroundColor = .white
    
    mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
    
    currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    currentLocationButton.backgroundColor = .white
    currentLocationButton.layer.cornerRadius = 20
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

  //MARK: - CLLocationManagerDelegate
extension LocationInformationViewController : CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse, .notDetermined :
      return
    default :
      viewModel.mapViewError.accept(MTMapViewError.locationAuthorizedDenied.errorDescription)
      return
    }
  }
}

  //MARK: - MTMapViewDelegate
extension LocationInformationViewController : MTMapViewDelegate {
  func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
    #if DEBUG
    viewModel.currentLocation.accept(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.394225, longitude: 127.110341)))
    #else
    viewModel.currentLocation.accpet(location)
    #endif
    
  }
  
  func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
     viewModel.mapCenterPoint.accept(mapCenterPoint)
  }
  
  func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
    viewModel.selectPOIItem.accept(poiItem)
    return false
  }
  
  func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) {
    viewModel.mapViewError.accept(error.localizedDescription)
  }
}

  //MARK: - extension Reactive
extension Reactive where Base : MTMapView {
  var setMapCenterPoint : Binder<MTMapPoint> {
    return Binder(base) { base, point in
      base.setMapCenter(point, animated: true)
    }
  }
}

  //MARK: - extension Reactive
extension Reactive where Base : LocationInformationViewController {
  var presentAlert : Binder<String> {
    return Binder(base) { base, message in
      let alertController = UIAlertController(title: "문제가 발생했어요", message: message, preferredStyle: .alert)
      let action = UIAlertAction(title: "확인", style: .default, handler: nil)
      alertController.addAction(action)
      
      base.present(alertController, animated: true, completion: nil)
    }
  }
}
