//
//  SelectionTableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
   @IBOutlet weak var lblName: UILabel!
   @IBOutlet weak var lblActive: UILabel!
   @IBOutlet weak var lblRectangles: UILabel!
   @IBOutlet weak var lblOperations: UILabel!
   @IBOutlet weak var wrapperView: UIView!
   
   var content: Selection? {
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
      lblName.text = ""
      lblActive.text = ""
      lblRectangles.text = ""
      lblOperations.text = ""
   }
   
   func setup() {
      reset()
      
      if let content = content {
         lblName.text = content.name ?? ""
         lblActive.text = (content.active ?? true) ? "Active" : "Inactive"
         
         if let rects = content.rectangles,
            rects.count > 0 {
            var str = String(describing: rects[0].self)
            
            for rect in rects.dropFirst() {
               str.append(", ")
               str.append(String(describing: rect.self))
            }
         }
         
         if let ops = content.ops,
            ops.count > 0 {
            var str = String(describing: ops[0].self)
            
            for op in ops.dropFirst() {
               str.append(", ")
               str.append(String(describing: op.self))
            }
         }
      }
   }
}


// MARK: - ReusableView

extension SelectionTableViewCell: ReusableView {}
