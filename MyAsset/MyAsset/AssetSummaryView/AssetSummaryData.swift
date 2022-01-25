//
//  AssetSummaryData.swift
//  MyAsset
//
//  Created by 윤병일 on 2022/01/24.
//

import SwiftUI

class AssetSummaryData: ObservableObject {
  @Published var assets : [Asset] = load("assets.json")// 어떠한 데이터를 내보낸다
  
}

func load<T : Decodable>(_ filename: String) -> T {
  let data : Data
  
  guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
    fatalError(filename + "을 찾을 수 없습니다")
  }
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError(filename + "을 찾을 수 없습니다.")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError(filename + "을 \(T.self) 로 파싱할 수 없습니다.")
  }
}
