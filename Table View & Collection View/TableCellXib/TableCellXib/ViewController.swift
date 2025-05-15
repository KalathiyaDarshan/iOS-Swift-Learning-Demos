//
//  ViewController.swift
//  TableCellXib
//
//  Created by mac on 04/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTableView: UITableView!
    var arrnumb:[Int] = [1,2,3,4,5,6,7,8,9,10]
    override func viewDidLoad() {
        super.viewDidLoad()
          
       myTableView.register(UINib(nibName: "MyCellXib", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrnumb.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCellXib
        cell.lblNumber.text = "\(arrnumb[indexPath.row])"
        return cell
    }
    
    
}
