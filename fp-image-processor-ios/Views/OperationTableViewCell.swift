//
//  OperationTableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {
   @IBOutlet weak var lblName: UILabel!
   @IBOutlet weak var lblAttributes: UILabel!
   @IBOutlet weak var wrapperView: UIView!
   
   var content: Operation?
   
   
   // MARK: - Lifecycle
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      wrapperView.layer.cornerRadius = 8.0
   }
   
   
   // MARK: - Setup
   
   private func reset() {
      lblName.text = ""
      lblAttributes.text = ""
   }
   
   func setup() {
      reset()
      
      guard let content = content else { return }
      
      lblName.text = "\(content.name ?? "")"
      if let mc = content.mc {
         lblAttributes.text?.append("RGB: (\(mc.r ?? 0.0), \(mc.r ?? 0.0), \(mc.r ?? 0.0))\n")
      }
      
      if let ops = content.ops {
         lblAttributes.text?.append(ops[0].name ?? "")
         for op in ops.dropFirst() {
            lblAttributes.text?.append(", \(op.name ?? "")")
         }
         
         lblAttributes.text?.append("\n")
      }
      
      if let w = content.w,
         let h = content.h {
         lblAttributes.text?.append("WH: (\(w), \(h))\n")
      }
      
      if let mat = content.pMat {
         lblAttributes.text?.append("pMat: \n")
         for arr in mat {
            if arr.count > 0 {
               lblAttributes.text?.append("[(\(arr[0].r ?? 0.0), \(arr[0].r ?? 0.0), \(arr[0].r ?? 0.0))")
               for el in arr.dropFirst() {
                  lblAttributes.text?.append(", (\(el.r ?? 0.0), \(el.r ?? 0.0), \(el.r ?? 0.0))")
               }
               lblAttributes.text?.append("]\n")
            }
         }
      }
   }
}


// MARK: - ReusableView

extension OperationTableViewCell: ReusableView {}
