//
//  ViewController.swift
//  IBDesignable&IBInspectable
//
//  Created by mac on 14/06/24.
//

// App Color and @IBDesignable,@IBInspectable
import UIKit

class ViewController: UIViewController {

    @IBOutlet var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MainView.backgroundColor = .pinkColor() //.primaryColor
        for i in 1...5{
            for b in 1...i {
                print(b,terminator:" ")
            }
            print()
        }
        
        for i in 1...5{
            for _ in i...5 {
                print("",terminator:" ")
            }
            for b in 1...i {
                print(b,terminator:" ")
            }
            print()
        }
    }
}

@IBDesignable
class CornerRadius:UIView {
    @IBInspectable var cornerRadius: Double{
        get{
            return Double(self.layer.cornerRadius)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth: Double{
        get{
            return Double(self.layer.borderWidth)
        }
        set{
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor{
        get{
            return UIColor(cgColor:  self.layer.borderColor!)
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
}

extension UIColor {
    convenience init(hexacode: Int) {
        self.init(
            red: CGFloat((hexacode >> 16) & 0xFF) / 255.0,
            green: CGFloat((hexacode >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hexacode & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}
// Usage
//let color = UIColor(hexacode: 0xffffff)


extension UIColor {
    static let primaryColor = UIColor(named: "Color") ?? .white
    
   static func pinkColor() -> UIColor{
        return UIColor(red: 255, green: 15, blue: 255, alpha: 80.7)
    }
}
