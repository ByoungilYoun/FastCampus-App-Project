//
//  LocalNetworkStub.swift
//  FindConvenienceStoreAppTests
//
//  Created by 윤병일 on 2022/01/04.
//

import Foundation
import RxSwift
import Stubber // 가상의 더미 데이터를 주입해서 마치 네트워크 상에서 적절한 json 또는 response 가 전달되었을때 그것을 네트워크처럼 전달해주는 테스트를 위한 라이브러리

@testable import FindConvenienceStoreApp

class LocalNetworkStub : LocalNetwork {
  override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
    return Stubber.invoke(getLocation, args: mapPoint)
  }
}

