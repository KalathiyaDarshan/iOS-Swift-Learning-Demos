//
//  secondViewController.swift
//  enumtask1
//
//  Created by mac on 20/05/24.
//

import UIKit

class secondViewController: UIViewController {
    
    @IBOutlet var lblStatus2: UILabel!
    @IBOutlet var lblStatus1: UILabel!
    @IBOutlet var lblStatus3: UILabel!
  
    @IBOutlet var lblproduct1: UILabel!
    @IBOutlet var lblproduct2: UILabel!
    @IBOutlet var lblproduct3: UILabel!
    @IBOutlet var lblproduct4: UILabel!
    @IBOutlet var lblproduct5: UILabel!
    @IBOutlet var lblproduct6: UILabel!
    
    @IBOutlet var lblprice1: UILabel!
    @IBOutlet var lblprice2: UILabel!
    @IBOutlet var lblprice3: UILabel!
    @IBOutlet var lblprice4: UILabel!
    @IBOutlet var lblprice5: UILabel!
    @IBOutlet var lblprice6: UILabel!
    
    @IBOutlet var lblOrder1: UILabel!
    @IBOutlet var lblOrder2: UILabel!
    @IBOutlet var lblOrder3: UILabel!
    
    @IBOutlet var lblName1: UILabel!
    @IBOutlet var lblName2: UILabel!
    @IBOutlet var lblName3: UILabel!
    
    @IBOutlet var lblProductStatus1: UILabel!
    @IBOutlet var lblProductStatus2: UILabel!
    @IBOutlet var lblProductStatus3: UILabel!
    @IBOutlet var lblProductStatus4: UILabel!
    @IBOutlet var lblProductStatus5: UILabel!
    
    @IBOutlet var lblProductStatus6: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var arrProduct = [Product]()
        var arrProduct2 = [Product]()
        var arrProduct3 = [Product]()
        
        let objPrd = Product(pname: "Parlay", price: 50,prsStatus: 1)
        arrProduct.append(objPrd)
        let objPrd1 = Product(pname: "Kitkat", price: 100,prsStatus: 2)
       arrProduct.append(objPrd1)
     
        let objPrd2 = Product(pname: "CrackJack", price: 10,prsStatus: 1)
        arrProduct2.append(objPrd2)
      let objPrd3 = Product(pname: "Moneko", price: 5,prsStatus: 1)
        arrProduct2.append(objPrd3)
        let objPrd4 = Product(pname: "5 Star", price: 80,prsStatus: 2)
          arrProduct2.append(objPrd4)
        
        let objPrd5 = Product(pname: "DaryMilk", price: 100,prsStatus: 1)
          arrProduct3.append(objPrd5)
        let objPrd6 = Product(pname: "ZimZam", price: 70,prsStatus: 2)
          arrProduct3.append(objPrd6)
       
        
        
        
        let od1 = orderdetails1(id: 1, name: "Darshan",status: 1, arrProducts: arrProduct)
        let od2 = orderdetails1(id: 2, name: "MayurBhai",status: 2,arrProducts: arrProduct2)
        let od3 = orderdetails1(id: 3, name: "Maldebhai",status: 1,arrProducts: arrProduct3)
        
        let arrayobj = [od1,od2,od3]
        
        shop(txtid: lblOrder1, txtname: lblName1, txtstatus: lblStatus1, obj: arrayobj[0])
        shop(txtid: lblOrder2, txtname: lblName2, txtstatus: lblStatus2, obj: arrayobj[1])
        shop(txtid: lblOrder3, txtname: lblName3, txtstatus: lblStatus3, obj: arrayobj[2])
        
        PrdNames(txtNm: lblproduct1, txtPrs: lblprice1, txtSts: lblProductStatus1, obj1: arrayobj[0].productarray[0])
        PrdNames(txtNm: lblproduct2, txtPrs: lblprice2, txtSts: lblProductStatus2, obj1: arrayobj[0].productarray[1])
        PrdNames(txtNm: lblproduct3, txtPrs: lblprice3, txtSts: lblProductStatus3, obj1: arrayobj[1].productarray[0])
       PrdNames(txtNm: lblproduct4, txtPrs: lblprice4, txtSts: lblProductStatus4, obj1: arrayobj[1].productarray[1])
        PrdNames(txtNm: lblproduct5, txtPrs: lblprice5, txtSts: lblProductStatus5, obj1: arrayobj[1].productarray[2])
        PrdNames(txtNm: lblproduct6, txtPrs: lblprice6, txtSts: lblProductStatus6, obj1: arrayobj[2].productarray[0])
    
    
    }
    
    func shop(txtid: UILabel,txtname: UILabel,txtstatus: UILabel,obj: orderdetails1){
        
        txtid.text = "\(obj.id)" // String(arrayobj[0].id)
        txtname.text = obj.name
        txtstatus.text = "\(obj.status)"
    
        
        switch obj.status {
            case .Deliverd:
                txtstatus.backgroundColor = .green
            case .Return:
                txtstatus.backgroundColor = .systemPink
        }
    }
    
    func PrdNames(txtNm: UILabel,txtPrs:UILabel,txtSts:UILabel,obj1: Product){
        txtNm.text = obj1.pname
        txtPrs.text = "\(obj1.price)"
        txtSts.text = "\(obj1.Prsstatus)"
   }
    
    
}
enum orderstatus1: Int{
    typealias RawValue = Int
   
    case Deliverd = 1
    case Return = 2
    
}
class orderdetails1{
    var id:Int
    var name:String
   var status:orderstatus1
    var productarray:[Product]
    

    init(id: Int,name: String,status: Int, arrProducts: [Product]) {
        self.id = id
        self.name = name
        self.status = orderstatus1(rawValue: status)!
        self.productarray = arrProducts
    }
}

class Product {
    var pname:String
    var price:Int
    var Prsstatus: orderstatus1
    
    init(pname:String,price:Int,prsStatus: Int) {
        self.pname = pname
        self.price = price
        self.Prsstatus = orderstatus1(rawValue: prsStatus)!
    }
}
