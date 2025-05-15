//
//  ViewController.swift
//  restaurantMenuTableView
//
//  Created by mac on 05/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    var arrHotFlavor = [Tea]()  // 1 Flavor Array
    var arrChaiWithoutMilk = [Tea]() // 2 Flavor Array
    var arrIcedTea = [Tea]() // 3 Flavor Array
    
    var arrAllObj = [[Tea]]()
    
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.tableFooterView = UIView()
        
        // 1 Flavor
        let hotFlavorTea1 = Tea.init(item: "Traditional Tea", price: 50)
        let hotFlavorTea2 = Tea.init(item: "Indian Masala", price: 55)
        let hotFlavorTea3 = Tea.init(item: "Elaichi", price: 55)
        let hotFlavorTea4 = Tea.init(item: "Pudina Elaichi", price: 55)
        let hotFlavorTea5 = Tea.init(item: "Ginger Pudina", price: 60)
        let hotFlavorTea6 = Tea.init(item: "Gud Wali Chal", price: 65)
        let hotFlavorTea7 = Tea.init(item: "Zafran Tea", price: 85)
        arrHotFlavor = [hotFlavorTea1,hotFlavorTea2,hotFlavorTea3,hotFlavorTea4,hotFlavorTea5,hotFlavorTea6,hotFlavorTea7]
        
        // 2 Flavor
        let chaiWithoutMilk1 = Tea.init(item: "Black Tea", price: 50)
        let ChaiWithoutMilk2 = Tea.init(item: "Kavo", price: 60)
        let ChaiWithoutMilk3 = Tea.init(item: "Green Tea", price: 60)
        let ChaiWithoutMilk4 = Tea.init(item: "Helthy Tea", price: 60)
        arrChaiWithoutMilk = [chaiWithoutMilk1,ChaiWithoutMilk2,ChaiWithoutMilk3,ChaiWithoutMilk4]
        
        // 3 Flavor
        let icedTea1 = Tea.init(item: "Lemon", price: 115)
        let icedTea2 = Tea.init(item: "Blueberry Mint", price: 115)
        let icedTea3 = Tea.init(item: "peach", price: 115)
        arrIcedTea = [icedTea1,icedTea2,icedTea3]
        
        // All Object in One Array
        arrAllObj = [arrHotFlavor,arrChaiWithoutMilk,arrIcedTea]
        tblView.reloadData()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrAllObj.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllObj[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let arrCategory = arrAllObj[indexPath.section]
        let catItem = arrCategory[indexPath.row]
        cell.textLabel?.text = "Items: \(catItem.item) <--> Price: \(catItem.price)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Hot Flavor Tea"
        }
        else if section == 1 {
            return "Chai Without Milk"
        }
        else if section == 2{
            return "Iced Tea"
        }
        return ""
    }
}

class Tea{
    var item: String
    var price: Int
    
    init(item:String,price: Int) {
        self.item = item
        self.price = price
    }
}

