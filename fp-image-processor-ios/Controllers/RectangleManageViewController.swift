//
//  RectanglesViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class RectangleManageViewController: UIViewController {
   @IBOutlet weak var lblStart: UILabel!
   @IBOutlet weak var lblEnd: UILabel!
   var rectangle: Rectangle?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if let rectangle = rectangle {
         lblStart.text = "(\(rectangle.start?.x ?? 0), \(rectangle.start?.y ?? 0))"
         lblEnd.text = "(\(rectangle.end?.x ?? 0), \(rectangle.end?.y ?? 0))"
      }
   }
   
}
