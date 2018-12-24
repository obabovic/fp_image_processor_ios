//
//  UIView.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/17/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

extension UIView {
   func round(byHeight: Bool = true) {
      let cornerRadius = byHeight ? frame.height/2 : frame.width/2
      layer.cornerRadius = cornerRadius
   }
}
