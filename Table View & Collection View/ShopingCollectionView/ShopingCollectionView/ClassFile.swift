
import Foundation

class Brand{
    var images: String
    var product:[Product]
    init(image:String,products: [Product]) {
        self.images = image
        self.product = products
    }
}

class Product {
    var name: String
    var price: Int
    var detail: String
    var productImage: String
    
    init(name:String,price:Int,detail:String,productImage:String) {
        self.name = name
        self.price = price
        self.detail = detail
        self.productImage = productImage
    }
}


