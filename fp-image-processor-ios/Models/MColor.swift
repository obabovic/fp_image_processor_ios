//
//  MColor.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class MColor: APIEntity {
   var r: Float?
   var g: Float?
   var b: Float?
   var a: Float?
   
   required init(fromJSON json: JSON) {
      r = json[Key.r].float
      g = json[Key.g].float
      b = json[Key.b].float
      a = json[Key.a].float
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      json[Key.r] = r
      json[Key.g] = g
      json[Key.b] = b
      json[Key.a] = a
      
      return json
   }
}
