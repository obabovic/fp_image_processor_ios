//
//  Selection.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Selection: APIEntity, Codable {
   var rectangles: [Rectangle]?
   
   required init(fromJSON json: JSON) {
      if let arr = json[Key.rectangles].array {
         rectangles = []
         for jsonRectangle in arr {
            rectangles?.append(Rectangle(fromJSON: jsonRectangle))
         }
      }
   }
}
