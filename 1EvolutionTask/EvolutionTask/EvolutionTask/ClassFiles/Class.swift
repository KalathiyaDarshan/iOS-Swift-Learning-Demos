//
//  File.swift
//  EvolutionTask
//
//  Created by mac on 04/07/24.
//

import Foundation

class MainCatagory: Codable {
    var id: String
    var name: String
    var arrProduct: [ProductList]
    var isExpand: Bool
    
    init(id:String,name:String,arrProuduct: [ProductList],isExpand: Bool) {
        self.id = id
        self.name = name
        self.arrProduct = arrProuduct
        self.isExpand = isExpand
    }
}

class ProductList: Codable {
    var id: String
    var productName: String
    var qty: Int
    
    init(id: String, productName:String,qty:Int) {
      
        self.productName = productName
        self.qty = qty
        self.id = id
    }
}

