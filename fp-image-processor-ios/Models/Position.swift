//
//  Position.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Position: APIEntity, Codable {
   var x: Int?
   var y: Int?

   required init(fromJSON json: JSON) {
      x = json[Key.x].int
      y = json[Key.y].int
   }
}
