//
//  ViewController.swift
//  MVCDemo
//
//  Created by Apple on 01/10/24.
//

import UIKit

class ViewController: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtQty: UITextField!

    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrObjProduct: [Product] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetTextField()
    }

    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func resetTextField(){
        txtName.text = ""
        txtQty.text = ""
        txtPrice.text = ""
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnView(_ sender: UIBarButtonItem) {
        let listVC = storyboard?.instantiateViewController(identifier: "ListVC") as! ListVC
        listVC.arrObjProduct = arrObjProduct
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        let obj = Product.init(name: txtName.text ?? "", price: Double(txtPrice.text ?? "") ?? 0.00, quantity: Int(txtQty.text ?? "") ?? 0)
        
        arrObjProduct.append(obj)
        resetTextField()
    }
}

