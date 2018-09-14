//
//  OperationsViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

protocol OperationsModalViewControllerDelegate {
   func operationsModalViewControllerWillFinish(operations: [Operation])
}

class OperationsModalViewController: UIViewController {
   var selectedOperations: [Operation] = []
   var items = DB.shared.operations
   var delegate: OperationsModalViewControllerDelegate?
   
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
      tableView.allowsMultipleSelection = true
      tableView.register(UINib(nibName: String(describing: OperationTableViewCell.self), bundle: nil), forCellReuseIdentifier: OperationTableViewCell.identifier)
   }
   
   
   @IBAction func donePressed(_ sender: Any?) {
      defer {
         dismiss(animated: true, completion: nil)
      }
      
      if let rows = tableView.indexPathsForSelectedRows {
         for item in rows {
            selectedOperations.append(items[item.row])
         }
         
         delegate?.operationsModalViewControllerWillFinish(operations: selectedOperations)
      }
   }
}


// MARK: - UITableViewDelegate

extension OperationsModalViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }
}


// MARK: - UITableViewDataSource

extension OperationsModalViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: OperationTableViewCell.identifier, for: indexPath) as! OperationTableViewCell
      cell.content = items[indexPath.row]
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
   }
}
