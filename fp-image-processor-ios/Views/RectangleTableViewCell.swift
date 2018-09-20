//
//  RectangleTableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class RectangleTableViewCell: UITableViewCell {
   @IBOutlet weak var lblStart: UILabel!
   @IBOutlet weak var lblEnd: UILabel!
   @IBOutlet weak var wrapperView: UIView!
   
   
   var content: Rectangle? {
      didSet {
         setup()
      }
   }
   
   
   // MARK: - Lifecycle
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      wrapperView.layer.cornerRadius = 8.0
   }
   
   
   // MARK: - Setup
   
   private func reset() {
      lblStart.text = ""
      lblEnd.text = ""
   }
   
   func setup() {
      reset()
      
      if let content = content,
         let s = content.start,
         let e = content.end,
         let sx = s.x,
         let sy = s.y,
         let ex = e.x,
         let ey = e.y {
         lblStart.text = "(\(sx), \(sy))"
         lblStart.text = "(\(ex), \(ey))"
      }
   }
}


// MARK: - ResuableView

extension RectangleTableViewCell: ReusableView {}
