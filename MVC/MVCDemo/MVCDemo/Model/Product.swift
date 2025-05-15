//
//  Product.swift
//  MVCDemo
//
//  Created by Apple on 01/10/24.
//

import Foundation

class Product {
    var name: String
    var price: Double
    var quantity: Int

    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }

    func totalPrice() -> Double {
        return price * Double(quantity)
    }
}
