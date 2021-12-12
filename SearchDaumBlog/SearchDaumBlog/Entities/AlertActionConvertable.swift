//
//  AlertActionConvertable.swift
//  SearchDaumBlog
//
//  Created by 윤병일 on 2021/12/13.
//

import UIKit

protocol AlertActionConvertable {
  var title : String { get }
  var style : UIAlertAction.Style { get }
}
