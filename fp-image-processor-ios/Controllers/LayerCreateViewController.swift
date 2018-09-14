//
//  LayerCreateViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit
import Toast_Swift

class LayerCreateViewController: UIViewController {
   @IBOutlet weak var txtImageName: UITextField!
   @IBOutlet weak var txtId: UITextField!
   @IBOutlet weak var txtAlpha: UITextField!
   @IBOutlet weak var switchIsActive: UISwitch!
   @IBOutlet weak var btnSubmit: UIButton!
   
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   
   // MARK: - Util
   
   func validate() -> Bool {
      var res = true
      var toastMsg = ""
      
      if txtImageName.text == nil || txtImageName.text == "" {
         res = false
         toastMsg = "Image name empty.\n"
      }
      
      if txtId.text == nil || txtId.text == "" {
         res = false
         toastMsg.append("Id is empty.\n")
      }
      
      if txtAlpha.text == nil || txtAlpha.text == "" {
         res = false
         toastMsg.append("Alpha is empty.\n")
      }
      
      return res
   }
   
   
   // MARK: - Actions
   
   @IBAction func btnSubmitAction(_ sender: Any) {
      guard validate() else { return }
      
      if let id = txtId.text,
         let imagePath = txtImageName.text,
         let alpha = txtAlpha.text {
         DB.shared.layers.append(Layer(id: Int(id), imagePath: imagePath, alpha: Float(alpha), active: switchIsActive.isOn))
         
         navigationController?.popViewController(animated: true)
      }
   }
}
