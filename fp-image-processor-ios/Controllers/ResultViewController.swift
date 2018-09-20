//
//  ResultViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit
import AlamofireImage

class ResultViewController: UIViewController {
   @IBOutlet weak var img: UIImageView!
   
   var urlString: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
   
      if let urlString = urlString {
         
         img.af_setImage(withURL: Router.baseAssetsURL.appendingPathComponent(urlString))
      }
   }
}
