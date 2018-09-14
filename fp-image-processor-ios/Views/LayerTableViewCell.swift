//
//  LayerTableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class LayerTableViewCell: UITableViewCell {
   var content: Layer? {
      didSet {
         setup()
      }
   }
   
   
   // MARK: - Setup
   
   func reset() {
      
   }
   
   func setup() {
      reset()
      
      //TODO: Setup
   }
}
