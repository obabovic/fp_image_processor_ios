//
//  MColor.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class MColor: APIEntity, Codable {
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
}
