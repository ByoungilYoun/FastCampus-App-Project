//
//  CreditCardModel.swift
//  CreditCardList
//
//  Created by 윤병일 on 2021/09/19.
//

import Foundation

struct CreditCardModel : Codable {
  let id : Int
  let rank : Int
  let name : String
  let cardImageURL : String
  let promotionDetail : PromotionDetail
  let isSelected : Bool? // 데이터 모델에는 없지만 나중에
  
}

struct PromotionDetail : Codable {
  let companyName : String
  let period : String
  let amount : Int
  let condition : String
  let benefitCondition : String
  let benefitDetail : String
  let benefitDate : String
}
