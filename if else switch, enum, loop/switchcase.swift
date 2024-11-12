let no = 2

switch no {
case 1:
    print("Sunday")
case 2:
    print("Monday")
    break
case 3:
    print("Tuesday")
case 4:
    print("Wednesday")
case 5:
    print("Thuosday")
    fallthrough
case 6:
    print("Frieday")
case 7:
    print("Saterday")    
default:
    print("Number note Valide")    
}

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

let productCode = Barcode.upc(8, 85909, 51226, 3)

switch productCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}


enum Details: String {
    case name = "Darshan"
}

let Person = Details.name
switch Person{
    case .name:
        print("Name: \(Person.rawValue)")
    default:
        print("Not Found")
}
