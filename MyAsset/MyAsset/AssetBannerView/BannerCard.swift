//
//  BannerCard.swift
//  MyAsset
//
//  Created by 윤병일 on 2022/01/24.
//

import SwiftUI

struct BannerCard: View {
  var banner : AssetBanner
  
    var body: some View {
      // 방법 1 ZStack 을 이용
      ZStack {
        Color(banner.backgroundColor)
        VStack {
          Text(banner.title)
            .font(.title)
          Text(banner.description)
            .font(.subheadline)
        }
      }
      
      
      // 방법 2 overlay 를 이용
//      Color(banner.backgroundColor)
//        .overlay(
//          VStack {
//            Text(banner.title)
//              .font(.title)
//            Text(banner.description)
//              .font(.subheadline)
//          }
//        )
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
      let banner0 = AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .red)
        BannerCard(banner: banner0)
    }
}
