//
//  File.swift
//  Collection&Tableview
//
//  Created by mac on 07/06/24.
//

import Foundation

class Category {
    var image: String
    var name: String
    var subCategoryArr: [SubCategory]
    
    init(image:String,name: String,subCategory: [SubCategory]) {
        self.image = image
        self.name = name
    
        self.subCategoryArr = subCategory
    }
}

class SubCategory{
    var subName: String
    var product: [Products]
    
    init(subName: String,product: [Products]) {
        self.subName = subName
        self.product = product
    }
}

class Products{
    var productName: String
    var image: String
    
    init(name: String,image: String) {
        self.productName = name
        self.image = image
    }
}
