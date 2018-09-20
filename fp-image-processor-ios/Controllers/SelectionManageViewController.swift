//
//  SelectionsViewController.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/14/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import UIKit

class SelectionManageViewController: UIViewController {
   var selection: Selection?
   
   var rectangles: [Rectangle] = []
   var selectedRectangle: Rectangle?
   
   @IBOutlet weak var lblName: UILabel!
   @IBOutlet weak var switchActive: UISwitch!
   @IBOutlet weak var lblOperations: UILabel!
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Setup tableView
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: String(describing: RectangleTableViewCell.self), bundle: nil), forCellReuseIdentifier: RectangleTableViewCell.identifier)
      tableView.separatorStyle = .none
      
      if let selection = selection {
         lblName.text = selection.name ?? ""
         switchActive.isOn = selection.active ?? true
         if let ops = selection.ops,
            ops.count > 0 {
            var str = String(describing: ops[0].self)
            
            for op in ops.dropFirst() {
               str.append(", ")
               str.append(String(describing: op.self))
            }
            lblOperations.text = str
         }
         
         if let rects = selection.rectangles {
            rectangles = rects
         }
      }
   }
   
   
   // MARK: - Navigation
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == Segue.showRectangleManage {
         let vc = segue.destination as! RectangleManageViewController
         
         vc.rectangle = selectedRectangle
      }
   }
}


// MARK: - UITableViewDelegate

extension SelectionManageViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      
      selectedRectangle = rectangles[indexPath.row]
      performSegue(withIdentifier: Segue.showRectangleManage, sender: self)
   }
}


// MARK: - UITableViewDataSource

extension SelectionManageViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: RectangleTableViewCell.identifier, for: indexPath) as! RectangleTableViewCell
      cell.content = rectangles[indexPath.row]
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return rectangles.count
   }
}
