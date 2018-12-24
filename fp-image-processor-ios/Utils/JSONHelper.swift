//
//  JSONHelper.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation

class JSONHelper {
   class func toJsonArray(fromArray arr: [APIEntity]) -> NSMutableArray {
      let res = NSMutableArray()
      
      for item in arr {
         res.add(item.toJSON())
      }
      
      return res
   }
}
