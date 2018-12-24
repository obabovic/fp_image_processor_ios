//
//  Operation.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Operation: APIEntity {
   var name: String?
   var mc : MColor?
   var w: Int?
   var h: Int?
   var pMat: [[MColor]]?
   var ops: [Operation]?
   var reverse: Bool?
   
   init() {}
   
   required init(fromJSON json: JSON) {
      name = json[Key.name].string
      w = json[Key.w].int
      h = json[Key.h].int
      reverse = json[Key.reverse].bool
      
      if json[Key.mc] != nil {
         mc = MColor(fromJSON: json[Key.mc])
      }
      
      if let arr = json[Key.ops].array {
         ops = []
         for jsonOp in arr {
            ops?.append(Operation(fromJSON: jsonOp))
         }
      }
      
      if let mat = json[Key.pMat].array,
         mat.count > 0 {
         pMat = []
         for arr in mat {
            if let arr = arr.array {
               var tmp: [MColor] = []

               for item in arr {
                  tmp.append(MColor(fromJSON: item))
               }
               
               pMat?.append(tmp)
            }
         }
      }
   }
   
   func toJSON() -> [String : Any] {
      var json: [String: Any] = [:]
      
      if let name = name { 
         json[Key.name] = name
      }
      
      if let mc = mc {
         json[Key.mc] = mc.toJSON()
      }
      
      if let w = w {
         json[Key.w] = w
      }
      
      if let h = h {
         json[Key.h] = h
      }
      
      if let reverse = reverse {
         json[Key.reverse] = reverse
      }
      
      if let pMat = pMat,
         pMat.count > 0 {
         var pMatAll: [NSMutableArray] = []
         
         for arr in pMat {
            pMatAll.append(JSONHelper.toJsonArray(fromArray: arr))
         }
         
         json[Key.pMat] = pMatAll
      } else if name == Key.Operation.mediana {
         json[Key.pMat] = []
      }
      
      if let ops = ops,
         ops.count > 0 {
         json[Key.ops] = JSONHelper.toJsonArray(fromArray: ops)
      }
      
      return json
   }
}
