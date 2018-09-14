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
   
   init(start: Position, end: Position) {
      self.start = start
      self.end = end
   }
   
   required init(fromJSON json: JSON) {
      start = Position(fromJSON: json[Key.start])
      end = Position(fromJSON: json[Key.end])
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      json[Key.start] = start?.toJSON()
      json[Key.end] = end?.toJSON()
      
      return json
   }
}
