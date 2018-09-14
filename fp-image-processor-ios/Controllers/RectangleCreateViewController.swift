//
//  RectangleCreateViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class RectangleCreateViewController: UIViewController {
   @IBOutlet weak var txtSelection: UITextField!
   @IBOutlet weak var txtStartX: UITextField!
   @IBOutlet weak var txtStartY: UITextField!
   @IBOutlet weak var txtEndX: UITextField!
   @IBOutlet weak var txtEndY: UITextField!
   @IBOutlet weak var btnSubmit: UIButton!
   
   var pickOptions: [Selection]!
   var selectedSelection: Selection?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Setup pickoption
      DB.shared.layers?.forEach({ (layer) in
         if let selections = layer.selections {
            self.pickOptions.append(contentsOf: selections)
         }
      })
      
      // Setup layers
      let pickerView = UIPickerView()
      
      pickerView.delegate = self
      
      txtSelection.inputView = pickerView
      txtSelection.text = "\(pickOptions[0].name ?? "")"
      selectedSelection = pickOptions[0]
   }
   
   
   // MARK: - Util
   
   func validate() -> Bool {
      var res = true
      var toastMsg = ""
      
      if txtStartX.text == nil || txtStartX.text == "" {
         res = false
         toastMsg.append("Start X is empty.\n")
      }
      
      if txtStartY.text == nil || txtStartY.text == "" {
         res = false
         toastMsg.append("Start Y is empty.\n")
      }
      
      if txtEndX.text == nil || txtEndX.text == "" {
         res = false
         toastMsg.append("End X is empty.\n")
      }
      
      if txtEndY.text == nil || txtEndY.text == "" {
         res = false
         toastMsg.append("End Y is empty.\n")
      }
      
      return res
   }
   
   
   // MARK: - Actions
   
   @IBAction func btnSubmitAction(_ sender: Any) {
      guard validate() else { return }
      
      if let startX = Int(txtStartX.text!),
         let startY = Int(txtStartY.text!),
         let endX = Int(txtEndX.text!),
         let endY = Int(txtEndY.text!) {
        
         let start = Position(x: startX, y: startY)
         let end = Position(x: endX, y: endY)
         selectedSelection?.rectangles?.append(Rectangle(start: start, end: end))
         navigationController?.popViewController(animated: true)
      }
   }
}


// MARK: - UIPickerViewDelegate

extension RectangleCreateViewController: UIPickerViewDelegate {}


// MARK: - UIPickerViewDataSource

extension RectangleCreateViewController: UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return pickOptions.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return pickOptions[row].name
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      selectedSelection = pickOptions[row]
      txtSelection.text = pickOptions[row].name
   }
}
