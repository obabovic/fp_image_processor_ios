//
//  DB.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class DB: APIEntity {
   var layers: [Layer]?
   var w: Int?
   var h: Int?
   
   required init(fromJSON json: JSON) {
      w = json[Key.w].int
      h = json[Key.h].int
      
      if let arr = json[Key.layers].array {
         layers = []
         for jsonLayer in arr {
            layers?.append(Layer(fromJSON: jsonLayer))
         }
      }
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      if let layers = layers {
         json[Key.layers] = JSONHelper.toJsonArray(fromArray: layers)
      }
      
      return json
   }
}
