//
//  LocalNetwork.swift
//  FindConvenienceStoreApp
//
//  Created by 윤병일 on 2021/12/30.
//

import RxSwift

class LocalNetwork {
  private let session : URLSession
  
  let api = LocalAPI()
  
  init(session : URLSession = .shared) {
    self.session = session
  }
  
  func getLocation(by mapPoint : MTMapPoint) -> Single<Result<LocationData, URLError>> {
    guard let url = api.getLocation(by: mapPoint).url else {
      return .just(.failure(URLError(.badURL)))
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("KakaoAK b560f08b8fb76549e744df5c2fa050df", forHTTPHeaderField: "Authorization")
    
    return session.rx.data(request: request as URLRequest)
      .map { data in
        do {
          let locationData = try JSONDecoder().decode(LocationData.self, from: data)
          return .success(locationData)
        } catch {
          return .failure(URLError(.cannotParseResponse))
        }
      }
      .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
      .asSingle()
  }
}
