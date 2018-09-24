//
//  LayersViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class LayerManageViewController: UIViewController {
   var layer: Layer?
   var selections: [Selection] = []
   var selectedSelection: Selection?
   
   @IBOutlet weak var lblId: UILabel!
   @IBOutlet weak var lblImg: UILabel!
   @IBOutlet weak var txtAlpha: UITextField!
   @IBOutlet weak var switchActive: UISwitch!
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Setup tableView
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: String(describing: SelectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: SelectionTableViewCell.identifier)
      tableView.separatorStyle = .none
      
      
      if let layer = layer,
         let selectionz = layer.selections {
         selections = selectionz
         switchActive.isOn = layer.active ?? true
         txtAlpha.text = "\(layer.alpha ?? 1.0)"
         lblId.text = "\(layer.id ?? 0)"
      }
      
      txtAlpha.delegate = self
   }
   
   
   // MARK: - Navigation
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == Segue.showSelectionManage {
         let vc = segue.destination as! SelectionManageViewController
         
         vc.selection = selectedSelection
      }
   }
   
   
   // MARK: - Actions
   
   @IBAction func switchActiveAction(_ sender: Any) {
      layer?.active = switchActive.isOn
   }
}


// MARK: - UITextFieldDelegate

extension LayerManageViewController: UITextFieldDelegate {
   func textFieldDidEndEditing(_ textField: UITextField) {
      if textField == txtAlpha,
         txtAlpha.text != "" {
         layer?.alpha = Float(txtAlpha.text ?? "1")
      }
      
      resignFirstResponder()
   }
}


// MARK: - UITableViewDelegate

extension LayerManageViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      
      selectedSelection = selections[indexPath.row]
      performSegue(withIdentifier: Segue.showSelectionManage, sender: self)
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if (editingStyle == UITableViewCellEditingStyle.delete) {
         selections.remove(at: indexPath.row)
         layer?.selections?.remove(at: indexPath.row)
         tableView.reloadData()
      }
   }
}


// MARK: - UITableViewDataSource

extension LayerManageViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.identifier, for: indexPath) as! SelectionTableViewCell
      cell.content = selections[indexPath.row]
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return selections.count
   }
}
