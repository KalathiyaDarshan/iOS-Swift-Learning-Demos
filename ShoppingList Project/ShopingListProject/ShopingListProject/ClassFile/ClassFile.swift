//
//  ClassFile.swift
//  ShopingListProject
//
//  Created by mac on 19/06/24.
//

class MainShopingList: Codable {
    var id: String
    var nameSL: String
    var priority: Priority
    var notes: String
    var arrProduct: [ProductList]
    var isExpand: Bool
    var totalProductPrice: Int
    var sortOrder: SortingOrder
    var sortBy: SortBy
    var deleteCheckMark: Bool
    
    init(id:String,nameSL:String,priority:Priority,notes:String,arrProuduct: [ProductList],isExpand: Bool,totalProductPrice: Int,sortOrder: SortingOrder,sortBy: SortBy,delete: Bool = false) {
        self.nameSL = nameSL
        self.priority = priority
        self.notes = notes
        self.arrProduct = arrProuduct
        self.id = id
        self.isExpand = isExpand
        self.totalProductPrice = totalProductPrice
        self.sortOrder = sortOrder
        self.sortBy = sortBy
        self.deleteCheckMark = delete
    }
    
    var checkedTotalPrice: Int {
        return arrProduct.filter { $0.chackMark }.reduce(0) { $0 + $1.productTotalPrice}
    }
    
    // Method to remove a product from arrProduct
    func removeProduct(at index: Int) {
        if index >= 0 && index < arrProduct.count {
            arrProduct.remove(at: index)
        } else {
            print("Product index out of range")
        }
    }
    
    func updateProduct(at index: Int, with newProduct: ProductList) {
            if index >= 0 && index < arrProduct.count {
                arrProduct[index] = newProduct
            } else {
                print("Product index out of range")
            }
        }
}

class ProductList: Codable {
    var id: String
    var productName: String
    var qty: Int
    var price: Int
    var notes: String
    var category: String
    var store: String
    var isExpand: Bool
    var productTotalPrice: Int
    var chackMark: Bool
    var deleteCheckMark: Bool
    
    init(id: String, productName:String,qty:Int,price:Int,notes:String,category:String,store: String,isExpand: Bool,checkMark: Bool,delete: Bool = false) {
        self.productName = productName
        self.qty = qty
        self.price = price
        self.notes = notes
        self.category = category
        self.store = store
        self.isExpand = isExpand
        self.productTotalPrice = qty*price
        self.chackMark = checkMark
        self.id = id
        self.deleteCheckMark = delete
    }
}

