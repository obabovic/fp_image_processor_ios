//
//  MainViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/13/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit
import SwiftyJSON
import Floaty

class MainViewController: UIViewController {
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let floaty = Floaty()
      
      floaty.addItem(title: "New Layer") { _ in
         
      }
      
      floaty.addItem(title: "New Selection") { _ in
         
      }
      
      floaty.addItem(title: "New Rectangle") { _ in
         
      }
      
      floaty.addItem(title: "New Operation") { _ in
         
      }
      
      self.view.addSubview(floaty)
   }
}
