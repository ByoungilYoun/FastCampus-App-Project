//
//  AlertActionConvertable.swift
//  RemakeSearchDaumBlog
//
//  Created by 윤병일 on 2022/02/03.
//

import UIKit

protocol AlertActionConvertable {
  var title : String { get }
  var style : UIAlertAction.Style { get }
}
