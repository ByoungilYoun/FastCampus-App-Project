//
//  LocationInformationModelTests.swift
//  FindConvenienceStoreAppTests
//
//  Created by 윤병일 on 2022/01/04.
//

import XCTest
import Nimble

@testable import FindConvenienceStoreApp

class LocationInformationModelTests: XCTestCase {

  let stubNetwork = LocalNetworkStub()
  
  var doc : [KLDocument]!
  var model : LocationInformationModel!
  
  override func setUp() {
    self.model = LocationInformationModel(localNetwork: stubNetwork)
    
    self.doc = cvsList
  }
  
  func testDocumentsToCellData() {
    let cellData = model.documentsToCellData(doc) // 실제 모델의 값
    let placeName = doc.map { $0.placeName } // dummy 값
    let address = cellData[1].address // 실제 모델의 값
    let roadAddressName = doc[1].roadAddressName // dummy 값
    
    expect(cellData.map { $0.placeName}).to(equal(placeName), description: "DetailListCellData의 placeName은 document의 placeName이다.")
    
    expect(address).to(equal(roadAddressName), description : "KLDocument의 RoadAddressName이 빈값이 아닌경우 roadAddress 가 cellData 에 전달된다.")
  }

}
