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
   @IBOutlet weak var lblAlpha: UILabel!
   @IBOutlet weak var switchActive: UISwitch!
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Setup tableView
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: String(describing: SelectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: SelectionTableViewCell.identifier)
      tableView.separatorStyle = .none
   }
}



// MARK: - UITableViewDelegate

extension LayerManageViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      
      selectedSelection = selections[indexPath.row]
      performSegue(withIdentifier: Segue.showLayerManage, sender: self)
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
