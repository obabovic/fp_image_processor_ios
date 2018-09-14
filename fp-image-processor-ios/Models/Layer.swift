//
//  Layer.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Layer: APIEntity {
   var id: Int?
   var imagePath: String?
   var alpha: Float?
   var active: Bool?
   var selections: [Selection]? = []

   init(id: Int?, imagePath: String?, alpha: Float?, active: Bool?) {
      self.id = id
      self.imagePath = imagePath
      self.alpha = alpha
      self.active = active
   }
   
   required init(fromJSON json: JSON) {
      id = json[Key.id].int
      imagePath = json[Key.imagePath].string
      alpha = json[Key.alpha].float
      active = json[Key.active].bool
      
      if let arr = json[Key.selections].array {
         selections = []
         for jsonSelection in arr {
            selections?.append(Selection(fromJSON: jsonSelection))
         }
      }
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      json[Key.id] = id
      json[Key.alpha] = alpha
      json[Key.active] = active
      
      if let selections = selections {
         json[Key.selections] = JSONHelper.toJsonArray(fromArray: selections)
      }
      
      return json
   }
}
