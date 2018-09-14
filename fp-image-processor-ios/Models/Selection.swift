//
//  Selection.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Selection: APIEntity {
   var name: String?
   var rectangles: [Rectangle]?
   var ops: [Operation]?
   var active: Bool?
   
   init(name: String, ops: [Operation], active: Bool) {
      self.name = name
      self.ops = ops
      self.active = active
   }
   
   required init(fromJSON json: JSON) {
      name = json[Key.name].string
      active = json[Key.active].bool
      if let arr = json[Key.rectangles].array {
         rectangles = []
         for jsonRectangle in arr {
            rectangles?.append(Rectangle(fromJSON: jsonRectangle))
         }
      }
      
      if let arr = json[Key.ops].array {
         ops = []
         for op in arr {
            ops?.append(Operation(fromJSON: op))
         }
      }
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      json[Key.name] = name
      json[Key.active] = active
      
      if let rectangles = rectangles {
         json[Key.rectangles] = JSONHelper.toJsonArray(fromArray: rectangles)
      }
      
      if let ops = ops {
         json[Key.ops] = JSONHelper.toJsonArray(fromArray: ops)
      }
      
      return json
   }
}
