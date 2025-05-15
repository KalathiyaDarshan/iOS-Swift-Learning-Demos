//
//  ViewController.swift
//  GetterSetter&WillsetDidset
//
//  Created by mac on 13/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tblNumber: UITableView!
    var arrNumber: [Int] = [1,2,3,4,5,6,7,8]{
        willSet(newValue){
            let sum = newValue.last! + arrNumber.last!
            return print("Will Set:", sum)
        }
        didSet{
            print("did Set")
            return tblNumber.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btnClick(_ sender: UIButton) {
        let number = Int.random(in: 1...1000)
        arrNumber.append(number)
        // tblNumber.reloadData()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNumber.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.lblNumber.text = "\(arrNumber[indexPath.row])"
        return cell
        
    }
    
    
}
