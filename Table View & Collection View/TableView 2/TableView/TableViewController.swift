//
//  TableViewController.swift
//  TableView
//
//  Created by mac on 04/06/24.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tblView: UITableView!
    var objTableCell: TableDetails?
    let count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
   
    }
}
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objTableCell?.section ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objTableCell?.rows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        cell.lblNumber.text = "\((indexPath.section*objTableCell!.rows)+(indexPath.row+1))"
        cell.viewColor.backgroundColor = objTableCell?.color[indexPath.section][indexPath.row] ?? .black
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section+1)"
    }
}



