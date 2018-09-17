//
//  UITableViewCell.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit


protocol ReusableView: class {
   static var identifier: String { get }
}

extension ReusableView where Self: UIView {
   static var identifier: String {
      return String(describing: self)
   }
}
