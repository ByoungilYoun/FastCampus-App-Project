//
//  Beer.swift
//  Brewery
//
//  Created by 윤병일 on 2021/11/14.
//

import Foundation

struct Beer : Decodable {
  let id : Int?
  let name, taglineString, description, brewersTips, imageURL : String?
  let foodPairing : [String]?
  
  var tagLine : String {
    let tags = taglineString?.components(separatedBy: ". ")
    let hashtags = tags?.map {
      "#" + $0.replacingOccurrences(of: " ", with: "") // 띄어쓰기 없애기
        .replacingOccurrences(of: ".", with: "") // 점이 남아있으면 없애기
        .replacingOccurrences(of: ",", with: " #")
    }
    return hashtags?.joined(separator: " ") ?? "" //해시태그들이 각각 띄어쓰기로 -> #tag #good 이런식으로 
  }
  
  enum CodingKeys : String, CodingKey {
    case id, name, description
    case taglineString = "tagline"
    case imageURL = "image_url"
    case brewersTips = "brewers_Tips"
    case foodPairing = "food_pairing"
  }
}
