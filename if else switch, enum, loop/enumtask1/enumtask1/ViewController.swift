//
//  ViewController.swift
//  enumtask1
//
//  Created by mac on 17/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblStatus2: UILabel!
    @IBOutlet var lblStatus1: UILabel!
    @IBOutlet var lblStatus3: UILabel!
    @IBOutlet var lblStatus4: UILabel!
    @IBOutlet var lblStatus5: UILabel!
    
    @IBOutlet var lblOrder1: UILabel!
    @IBOutlet var lblOrder2: UILabel!
    @IBOutlet var lblOrder3: UILabel!
    @IBOutlet var lblOrder4: UILabel!
    @IBOutlet var lblOrder5: UILabel!
    
    @IBOutlet var lblName1: UILabel!
    @IBOutlet var lblName2: UILabel!
    @IBOutlet var lblName3: UILabel!
    @IBOutlet var lblName4: UILabel!
    @IBOutlet var lblName5: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let od1 = orderdetails(id: 1, name: "Darshan",status: 1)
        let od2 = orderdetails(id: 2, name: "MayurBhai",status: 2)
        let od3 = orderdetails(id: 3, name: "Maldebhai",status: 3)
        let od4 = orderdetails(id: 4, name: "Shivam",status: 4)
        let od5 = orderdetails(id: 5, name: "Yash",status: 5)
        
        let arrayobj = [od1,od2,od3,od4,od5]
        
        shop(txtid: lblOrder1, txtname: lblName1, txtstatus: lblStatus1, obj: arrayobj[0])
        shop(txtid: lblOrder2, txtname: lblName2, txtstatus: lblStatus2, obj: arrayobj[1])
        shop(txtid: lblOrder3, txtname: lblName3, txtstatus: lblStatus3, obj: arrayobj[2])
        shop(txtid: lblOrder4, txtname: lblName4, txtstatus: lblStatus4, obj: arrayobj[3])
        shop(txtid: lblOrder5, txtname: lblName5, txtstatus: lblStatus5, obj: arrayobj[4])
        
    }
    
    func shop(txtid: UILabel,txtname: UILabel,txtstatus: UILabel,obj: orderdetails){
        
        txtid.text = "\(obj.id)" // String(arrayobj[0].id)
        txtname.text = obj.name
        txtstatus.text = "\(obj.status)"
        
        switch obj.status {
            case .Orderd:
                txtstatus.backgroundColor = .green
            case .Shiped:
                txtstatus.backgroundColor = .systemPink
            case .Deliverd:
                txtstatus.backgroundColor = .yellow
            case .Cancel:
                txtstatus.backgroundColor = .red
            case .Return:
                txtstatus.backgroundColor = .purple
        }
        
    }
}

enum orderstatus: Int{
    typealias RawValue = Int
    
    case Orderd = 1
    case Shiped = 2
    case Deliverd = 3
    case Cancel = 4
    case Return = 5
    
}

class orderdetails{
    var id:Int
    var name:String
    var status:orderstatus
    
    init(id: Int,name: String,status: Int) {
        self.id = id
        self.name = name
        self.status = orderstatus(rawValue: status)!
    }
    
}
