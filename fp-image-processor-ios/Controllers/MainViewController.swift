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
import PromiseKit

class MainViewController: UIViewController {
   @IBOutlet weak var tableView: UITableView!
   
   var layers: [Layer] = []
   var selectedLayer: Layer?
   var urlString: String?
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Setup tableView
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: String(describing: LayerTableViewCell.self), bundle: nil), forCellReuseIdentifier: LayerTableViewCell.identifier)
      tableView.separatorStyle = .none
      
      // Setup Floaty
      let floaty = Floaty()
      
      floaty.addItem(title: "New Layer") { _ in
         self.performSegue(withIdentifier: Segue.showLayerCreate, sender: self)
      }
      
      floaty.addItem(title: "New Operation") { _ in
         self.performSegue(withIdentifier: Segue.showOperationCreate, sender: self)
      }
      
      floaty.addItem(title: "New Selection") { _ in
         self.performSegue(withIdentifier: Segue.showSelectionCreate, sender: self)
      }
      
      floaty.addItem(title: "New Rectangle") { _ in
         self.performSegue(withIdentifier: Segue.showRectangleCreate, sender: self)
      }
      
      floaty.addItem(title: "Load Configuration") { _ in
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
         firstly {
            AppService.loadConfiguration()
            }.done { response in
               if let response = response {
                  DB.shared = response
                  self.layers = DB.shared.layers
                  self.tableView.reloadData()
               } else {
                  self.view.makeToast("No existing configuration")
               }
            }.catch { err in
               self.view.makeToast(err.localizedDescription)
            }.finally {
               UIApplication.shared.isNetworkActivityIndicatorVisible = false
         }
      }
      
      floaty.addItem(title: "Execute") { _ in
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
         firstly {
            AppService.formImage(request: DB.shared)
            }.done { response in
               self.urlString = response
               
               self.view.makeToast("Success!")
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {
                  self.performSegue(withIdentifier: Segue.showResult, sender: self)
               })
            }.catch { err in
               self.view.makeToast(err.localizedDescription)
            }.finally {
               UIApplication.shared.isNetworkActivityIndicatorVisible = false
         }
      }
      
      self.view.addSubview(floaty)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      layers = DB.shared.layers
      tableView.reloadData()
   }
   
   
   // MARK: - Navigation
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == Segue.showLayerManage {
         let vc = segue.destination as! LayerManageViewController
         
         vc.layer = selectedLayer
      } else if segue.identifier == Segue.showResult {
         let vc = segue.destination as! ResultViewController
         
         vc.urlString = urlString
      }
   }
}


// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      
      selectedLayer = layers[indexPath.row]
      performSegue(withIdentifier: Segue.showLayerManage, sender: self)
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if (editingStyle == UITableViewCellEditingStyle.delete) {
         DB.shared.layers.remove(at: indexPath.row)
         layers.remove(at: indexPath.row)
         tableView.reloadData()
      }
   }
}


// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: LayerTableViewCell.identifier, for: indexPath) as! LayerTableViewCell
      cell.content = layers[indexPath.row]
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return layers.count
   }
}
