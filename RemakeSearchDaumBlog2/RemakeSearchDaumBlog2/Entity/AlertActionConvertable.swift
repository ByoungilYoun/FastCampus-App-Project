//
//  AlertActionConvertable.swift
//  RemakeSearchDaumBlog2
//
//  Created by 윤병일 on 2022/06/09.
//

import Foundation
import UIKit

protocol AlertActionConvertable {
  var title : String { get }
  var style : UIAlertAction.Style { get }
}
