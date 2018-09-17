//
//  RectangleTableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class RectangleTableViewCell: UITableViewCell {
   var content: Rectangle? {
      didSet {
         setup()
      }
   }
   
   
   // MARK: - Lifecycle
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   
   // MARK: - Setup
   
   private func reset() {
      
   }
   
   func setup() {
      reset()
   }
}


// MARK: - ResuableView

extension RectangleTableViewCell: ReusableView {}
