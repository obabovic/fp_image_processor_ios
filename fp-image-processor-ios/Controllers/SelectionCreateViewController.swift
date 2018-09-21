//
//  SelectionCreateViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit
import Toast_Swift

class SelectionCreateViewController: UIViewController {
   @IBOutlet weak var txtName: UITextField!
   @IBOutlet weak var txtLayer: UITextField!
   @IBOutlet weak var txtOperations: UITextField!
   @IBOutlet weak var switchActive: UISwitch!
   @IBOutlet weak var btnSubmit: UIButton!
   
   var pickOptions: [Layer]! = DB.shared.layers
   var selectedLayer: Layer?
   
   var selectedOperations: [Operation] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      txtOperations.delegate = self
      
      if pickOptions.count > 0 {
         let pickerView = UIPickerView()
         pickerView.delegate = self
         txtLayer.inputView = pickerView
         txtLayer.text = "\(pickOptions[0].id ?? 0)"
         selectedLayer = pickOptions[0]
      }
   }
   
   
   // MARK: - Util
   
   func validate() -> Bool {
      var res = true
      var toastMsg = ""
      
      if txtName.text == nil || txtName.text == "" {
         res = false
         toastMsg.append("Name is empty.\n")
      }
      
      if txtOperations.text == nil || txtOperations.text == "" {
         res = false
         toastMsg.append("Operations field is empty.\n")
      }
      
      if selectedOperations.count == 0 {
         res = false
         toastMsg.append("Please choose an operation.\n")
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
         selectedLayer?.selections?.append(Selection(name: name, ops: selectedOperations, active: switchActive.isOn))
         
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

extension SelectionCreateViewController: UIPickerViewDelegate {}


// MARK: - UIPickerViewDataSource

extension SelectionCreateViewController: UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return pickOptions.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return String(describing: pickOptions[row].id)
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      selectedLayer = pickOptions[row]
      txtLayer.text = "\(pickOptions[row].id ?? 0)"
   }
}


// MARK: - UITextFieldDelegate

extension SelectionCreateViewController: UITextFieldDelegate {
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      performSegue(withIdentifier: Segue.presentOperations, sender: self)
      return false
   }
}


// MARK: - OperationsModalViewControllerDelegate

extension SelectionCreateViewController: OperationsModalViewControllerDelegate {
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
