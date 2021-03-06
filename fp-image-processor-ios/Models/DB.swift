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
   static var shared: DB = DB()
   
   var layers: [Layer] = []
   var operations: [Operation] = []
   var w: Int?
   var h: Int?
   
   // MARK: - Singleton
   
   private init() { w = 720; h = 1280 }
   
   class func initFromJSON(fromJSON json: JSON) {
      shared = DB(fromJSON: json)
   }
   
   // MARK: - APIEntity
   
   internal required init(fromJSON json: JSON) {
      w = json[Key.width].int
      h = json[Key.height].int
      
      if let arr = json[Key.layers].array {
         layers = []
         for jsonLayer in arr {
            layers.append(Layer(fromJSON: jsonLayer))
         }
      }
      
      if let arr = json[Key.ops].array {
         operations = []
         for jsonOperation in arr {
            operations.append(Operation(fromJSON: jsonOperation))
         }
      }
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      json[Key.height] = h
      json[Key.width] = w
      
      if layers.count > 0 {
         json[Key.layers] = JSONHelper.toJsonArray(fromArray: layers)
      }
      
      if operations.count > 0 {
         json[Key.ops] = JSONHelper.toJsonArray(fromArray: operations)
      }
      
      return json
   }
}
