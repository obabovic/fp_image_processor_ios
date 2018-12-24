//
//  LayerTableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class LayerTableViewCell: UITableViewCell {
   @IBOutlet weak var lblId: UILabel!
   @IBOutlet weak var lblImg: UILabel!
   @IBOutlet weak var lblAlpha: UILabel!
   @IBOutlet weak var lblActive: UILabel!
   @IBOutlet weak var wrapperView: UIView!
   
   var content: Layer? {
      didSet {
         setup()
      }
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      wrapperView.layer.cornerRadius = 8.0
   }
   
   
   // MARK: - Setup
   
   func reset() {
      lblId.text = ""
      lblImg.text = ""
      lblAlpha.text = ""
      lblActive.text = ""
   }
   
   func setup() {
      reset()
      
      if let content = content {
         lblId.text = "\(content.id ?? 0)"
         lblImg.text = "\(content.imagePath ?? "")"
         lblAlpha.text = "\(content.alpha ?? 1.0)"
         lblActive.text = (content.active ?? true) ? "Active" : "Inactive"
      }
   }
}


// MARK: - ReusableView

extension LayerTableViewCell: ReusableView {}
