//
//  ViewController.swift
//  xibAddView
//
//  Created by Apple on 23/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblCustomView: UITableView!
    
    var fruits = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Honeydew", "Kiwi", "Lemon", "Mango", "Nectarine", "Orange", "Papaya", "Quince"]

    var arrDemo = [Demo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCustomView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        creatObject()
    }
    
    func creatObject(){
        let obj1 = Demo.init(title: "title 1", discription: [Discription.init(discription: "discription 1"),Discription.init(discription: "discription 2"),Discription.init(discription: "discription 3")])
        
        let obj2 = Demo.init(title: "title 2", discription: [Discription.init(discription: "discription 1"),Discription.init(discription: "discription 2"),Discription.init(discription: "discription 3")])
        
        arrDemo.append(contentsOf: [obj1,obj2])

    }
    
    @IBAction func addButtonClick(_ sender: UIButton) {
        
        // Check if the fruits array is not empty before accessing its first element
        guard !fruits.isEmpty else {
            // Optionally show an alert or handle the empty state
            print("No more fruits to add.")
            return
        }
        
        let objDiscription = Discription.init(discription: fruits.first ?? "")
        
        arrDemo[0].discription.append(objDiscription)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tblCustomView.reloadRows(at: [indexPath], with: .automatic)
        
        fruits.remove(at: 0)
    }
    
}


extension ViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.setData(obj: arrDemo[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
}
