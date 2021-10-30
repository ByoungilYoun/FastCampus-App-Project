//
//  WeatherInformation.swift
//  Weather
//
//  Created by 윤병일 on 2021/10/30.
//

import Foundation

struct WeatherInformation : Codable { // Codable 은 자신을 변환하거나 외부 표현(Json 등과 같은) 으로 변환할 수 있는 타입을 의미한다. DeCodable & Encodable. 한마디로 Codable 프로토콜을 채택하면 WeatherInformation 객체를 Json 형태로 만들 수 있고, Json 형태를 WeatherInformation 객체로 만들 수 있다.
  
  let weather : [Weather]
  let temp : Temp
  let name : String
  
  enum CodingKeys : String, CodingKey {
    case weather
    case temp = "main"
    case name
  }
}

struct Weather : Codable {
  let id : Int
  let main : String
  let description : String
  let icon : String
}


struct Temp : Codable {
  let temp : Double
  let feelsLike : Double
  let minTemp : Double
  let maxTemp : Double
  
  enum CodingKeys : String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case minTemp = "temp_min"
    case maxTemp = "temp_max"
  }
}
