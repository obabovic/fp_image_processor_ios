//
//  Rectangle.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Rectangle: APIEntity, Codable {
   var start: Position?
   var end: Position?
   
   required init(fromJSON json: JSON) {
      start = Position(fromJSON: json[Key.start])
      end = Position(fromJSON: json[Key.end])
   }
}
