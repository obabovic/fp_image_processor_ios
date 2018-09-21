//
//  Key.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation

struct Key {
   static let x = "x"
   static let y = "y"
   static let width = "width"
   static let height = "height"
   static let start = "start"
   static let end = "end"
   static let url = "url"
   static let rectangles = "rectangles"
   static let selections = "selections"
   static let layers = "layers"
   static let ops = "ops"
   static let r = "r"
   static let g = "g"
   static let b = "b"
   static let a = "a"
   static let name = "name"
   static let mc = "mc"
   static let active = "active"
   static let alpha = "alpha"
   static let imagePath = "imagePath"
   static let id = "id"
   static let w = "w"
   static let h = "h"
   static let pMat = "pMat"
   static let reverse = "reverse"
   
   struct Operation {
      static let add = "add"
      static let sub = "sub"
      static let invsub = "invsub"
      static let mul = "mul"
      static let div = "div"
      static let invdiv = "invdiv"
      static let inv = "inv"
      static let greyscale = "greyscale"
      static let pow = "pow"
      static let log = "log"
      static let mediana = "mediana"
      static let ponder = "ponder"
      static let composite = "composite"
      static let chained = "chained"
   }
}
