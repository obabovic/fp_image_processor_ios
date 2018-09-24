//
//  OperationCreateViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit
import SwiftyJSON
import Toast_Swift

class OperationCreateViewController: UIViewController {
   @IBOutlet weak var txtName: UITextField!
   @IBOutlet weak var txtOperations: UITextField!
   @IBOutlet weak var txtR: UITextField!
   
   @IBOutlet weak var txtG: UITextField!
   @IBOutlet weak var txtB: UITextField!
   @IBOutlet weak var txtW: UITextField!
   @IBOutlet weak var txtH: UITextField!
   @IBOutlet weak var txtMatrix: UITextView!
   @IBOutlet weak var switchReverse: UISwitch!
   
   var pickOptions: [String]!
   var selectedOperations: [Operation] = []
   
   let arithmetic = Set(arrayLiteral: Key.Operation.add, Key.Operation.sub, Key.Operation.invsub, Key.Operation.mul, Key.Operation.div, Key.Operation.invdiv, Key.Operation.pow)
   let filter = Set(arrayLiteral: Key.Operation.mediana, Key.Operation.ponder)
   let composite = Set(arrayLiteral: Key.Operation.composite)
   
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Setup pickoption
      
      pickOptions = [
         Key.Operation.greyscale, Key.Operation.mediana,
         Key.Operation.ponder, Key.Operation.composite,
         Key.Operation.abs, Key.Operation.add,
         Key.Operation.sub, Key.Operation.invsub,
         Key.Operation.inv, Key.Operation.mul,
         Key.Operation.div, Key.Operation.invdiv,
         Key.Operation.max, Key.Operation.min,
         Key.Operation.pow, Key.Operation.log]
      
      let pickerView = UIPickerView()
      
      pickerView.delegate = self
      
      txtName.inputView = pickerView
      txtName.text = pickOptions[0]
      txtOperations.delegate = self
   }
   
   
   // MARK: - Util
   
   func validate() -> Bool {
      var res = true
      var toastMsg = ""
      
      if arithmetic.contains(txtName.text!) {
         if txtR.text == nil || txtR.text == "" {
            res = false
            toastMsg.append("R empty.\n")
         }
         if txtG.text == nil || txtG.text == "" {
            res = false
            toastMsg.append("G empty.\n")
         }
         if txtB.text == nil || txtB.text == "" {
            res = false
            toastMsg.append("B empty.\n")
         }
      } else if filter.contains(txtName.text!) {
         if txtW.text == nil || txtW.text == "" {
            res = false
            toastMsg.append("W empty.\n")
         }
         
         if txtH.text == nil || txtH.text == "" {
            res = false
            toastMsg.append("H empty.\n")
         }
         
         if txtName.text! == Key.Operation.ponder {
            let json = JSON(parseJSON: txtMatrix.text).arrayValue
            var count = 0
            
            for item in json {
               count += item.arrayValue.count
            }
            
            if count != (2*Int(txtW.text!)!+1) * (2*Int(txtH.text!)!+1) {
               res = false
               toastMsg.append("Matrix format not in sync with W + H.")
            }
         }
      } else if composite.contains(txtName.text!) {
         if selectedOperations.count == 0 {
            res = false
            toastMsg.append("Operations not selected.\n")
         }
      }
      
      if toastMsg != "" {
         self.view.makeToast(toastMsg)
      }
      
      return res
   }


   // MARK: - Actions
   
   @IBAction func btnSubmitAction(_ sender: Any) {
      guard validate() else { return }
      
      if let name = txtName.text {
         let operation = Operation()
         operation.name = name
         
         if let tr = txtR.text,
            let tg = txtG.text,
            let tb = txtB.text,
            let r = Float(tr),
            let g = Float(tg),
            let b = Float(tb) {
            operation.mc = MColor(r: r,g: g,b: b)
         }
         
         if let tw = txtW.text,
            let th = txtH.text,
            let w = Int(tw),
            let h = Int(th) {
            operation.w = w
            operation.h = h
         }
         
         
         let json = JSON(parseJSON: txtMatrix.text).arrayValue
         var mat: [[MColor]] = []
         
         for arr in json {
            var mArr: [MColor] = []
            if let arr = arr.array {
               for item in arr {
                  if let r = item.float {
                     mArr.append(MColor(r: r, g: r, b: r))
                  }
               }
            }
            mat.append(mArr)
         }
         
         if mat.count > 0 {
            operation.pMat = mat
         }
         
         operation.ops = selectedOperations
         
         if operation.name == Key.Operation.composite {
            operation.reverse = switchReverse.isOn
         }
         
         DB.shared.operations.append(operation)
         navigationController?.popViewController(animated: true)
      }
   }
   
   
   // MARK: - Navigation
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == Segue.presentOperations {
         let vc = segue.destination as! OperationsModalViewController
         
         vc.delegate = self
         definesPresentationContext = true
         vc.providesPresentationContextTransitionStyle = true
         vc.modalPresentationStyle = .overFullScreen
         vc.modalTransitionStyle = .crossDissolve
      }
   }
}


// MARK: - UIPickerViewDelegate

extension OperationCreateViewController: UIPickerViewDelegate {}


// MARK: - UIPickerViewDataSource

extension OperationCreateViewController: UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return pickOptions.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return pickOptions[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      txtName.text = pickOptions[row]
   }
}


// MARK: - UITextFieldDelegate

extension OperationCreateViewController: UITextFieldDelegate {
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      performSegue(withIdentifier: Segue.presentOperations, sender: self)
      return false
   }
}


// MARK: - OperationsModalViewControllerDelegate

extension OperationCreateViewController: OperationsModalViewControllerDelegate {
   func operationsModalViewControllerWillFinish(operations: [Operation]) {
      selectedOperations = operations
      if selectedOperations.count > 0 {
         var str = selectedOperations[0].name ?? ""
         
         for op in selectedOperations.dropFirst() {
            str.append(", ")
            str.append(op.name ?? "")
         }
         txtOperations.text = str
      }
   }
}
