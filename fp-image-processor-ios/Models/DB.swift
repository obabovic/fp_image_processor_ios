//
//  DB.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class DB: APIEntity, Codable {
   var layers: [Layer]?
   
   required init(fromJSON json: JSON) {
      if let arr = json[Key.layers].array {
         layers = []
         for jsonLayer in arr {
            layers?.append(Layer(fromJSON: jsonLayer))
         }
      }
   }
}
