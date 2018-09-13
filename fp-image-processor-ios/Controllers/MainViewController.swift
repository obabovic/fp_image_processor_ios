//
//  MainViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let json = JSON(parseJSON: "{\"width\":1920,\"height\":1080,\"layers\":[{\"id\":1,\"imagePath\":\"qwe.png\",\"alpha\":1,\"active\":true,\"selections\":[{\"name\":\"sel1\",\"active\":true,\"ops\":[{\"name\":\"greyscale\"}],\"rectangles\":[{\"start\":{\"x\":0,\"y\":0},\"end\":{\"x\":700,\"y\":700}}]}]}]}")
      
      var db = DB(fromJSON: json)
      print(db)
   }
}
