//
//  Extension.swift
//  CloudKey
//
//  Created by Bluepixel.
//  Copyright © 2020 Bluepixel. All rights reserved.
//

import Foundation
import UIKit

//let appdelegate = UIApplication.shared.delegate as! AppDelegate

//let kAppName = "BLEScanner"



let APP_NAME = "BLE Scanner"

extension UIViewController {
    
    //    func showHUD(_ text: String? = nil, dim: Bool = false) {
    //
    //        let hud = MBProgressHUD.showAdded(to: view, animated: true)
    //        hud.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    //        hud.isUserInteractionEnabled = false
    //        hud.animationType = MBProgressHUDAnimation.zoomIn
    //        UIApplication.shared.beginIgnoringInteractionEvents()
    //        hud.alpha = 0.9
    //        if let text = text {
    //            hud.label.text = text
    //        }
    //    }
    //
    //    func hideHUD() {
    //        DispatchQueue.main.async {
    //            MBProgressHUD.hide(for: self.view, animated: true)
    //            UIApplication.shared.endIgnoringInteractionEvents()
    //        }
    //    }
    
    func showAlertWith2ButtonswithColor(message:String,btnOneName:String,btnOneColor:UIColor,btnTwoName:String , btnTwoColor:UIColor ,complition:@escaping  (_ btnAction: Int) -> Void ) {
        
        let alert = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: btnOneName, style: .default) { (action) in
            complition(1)
        }
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: btnTwoName, style: .default) { (UIAlertActionaction2) in
            complition(2)
        }
        alert.addAction(action2)
        
        action1.setValue(btnOneColor, forKey: "titleTextColor")
        action2.setValue(btnTwoColor, forKey: "titleTextColor")
        
        
        present(alert, animated: true, completion: nil)
    }
    
    func removeAllVCFromStack() {
        
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!) //To remove all previous UIViewController except the last one
        self.navigationController?.viewControllers = navigationArray
    }
    
    func animateView(with option: UIView.AnimationOptions = [.curveLinear], animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: option, animations: animations, completion: completion)
    }
    
}

extension UIView {
    
    func GradientView(firstColor: UIColor, secondColor: UIColor){
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        
        // Create a gradient layer
        let gradient = CAGradientLayer()
        // gradient colors in order which they will visually appear
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        //        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        //        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        // set the gradient layer to the same size as the view
        gradient.frame = self.bounds
        // add the gradient layer to the views layer for rendering
        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func removelayerBG (Button: UIButton) {
        //Button.layer.sublayers?.remove(at: 0)
        if let layer = Button.layer.sublayers? .first {
            print ("Button.layer.sublayers:", Button.layer.sublayers ?? "")
            layer.removeFromSuperlayer ()
        }
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
    func expandShrinkingLoopAnimation(startX:Double = 1.0, startY:Double = 1.0, scaleX: Double = 1.0, scaleY: Double = 1.15, repeatCount: Int = 1) {
        self.superview?.bringSubviewToFront(self)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse], animations: { [weak self] in
            if repeatCount > 0 {
                UIView.modifyAnimations(withRepeatCount: CGFloat(repeatCount), autoreverses: true) {
                    self?.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)//1.5 times it's normal size
                }
                
            } else {
                self?.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            }
            
        }){ [weak self] (finished) in
            UIView.animate(withDuration: 0.7, delay: 0) { [weak self] in
                if repeatCount > 0 {
                    self?.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                    
                } else {
                    self?.transform = CGAffineTransform(scaleX: startX, y: startY)
                }
            }
        }
    }
    
}

extension Int {
    
    func randomNumber(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    var hexString: String {
        
        let unpaddedHex = String(self, radix: 16, uppercase: true)
        let stringCharCount = unpaddedHex.count
        let desiredPadding = 1 << Swift.max(fls(Int32(stringCharCount - 1)), 1) // Thanks, Greg Titus
        return unpaddedHex.leftPad("0", toWidth: Int(desiredPadding))
    }
}

extension UIViewController {
   
    func shareActivityApp(items: [Any], titleSubject: String? = nil, callback: (() -> ())? = nil) {
        
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if titleSubject != nil {
            activityViewController.setValue(titleSubject, forKey: "subject")
        }
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
        }
        self.present(activityViewController, animated: true, completion: callback)
    }
    
    func showAlertWithOKButton(title: String = APP_NAME, message: String, _ complition: (() -> ())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okaction = UIAlertAction(title: "Okay", style: .cancel)  { (ok) in
            complition?()
        }
        alert.addAction(okaction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String = APP_NAME, massage: String, buttontitle: String = "Okay") {
        
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttontitle, style: .default, handler: { action in
            switch action.style{
                    
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destuctive")
                    
                default:
                    break
            }
        }))
        self.present(alert, animated: true , completion: nil)
    }
    
    func showAlertWith2Buttons(message:String, btnOneName:String, btnTwoName:String, complition:@escaping  (_ btnAction:Int) -> Void ) {
        
        let alert = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: btnOneName, style: .default) { (action) in
            complition(1)
        }
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: btnTwoName, style: .default) { (UIAlertActionaction2) in
            complition(2)
        }
        alert.addAction(action2)
        
        present(alert, animated: true, completion: nil)
    }
    
    //    var isValidEmail: Bool {
    //       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
    //       return testEmail.evaluate(with: self)
    //    }
}


extension NSLayoutConstraint {
    
    static func setMultiplier(_ multiplier: CGFloat, of constraint: inout NSLayoutConstraint) {
        NSLayoutConstraint.deactivate([constraint])
        
        let newConstraint = NSLayoutConstraint(item: constraint.firstItem as Any, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: multiplier, constant: constraint.constant)
        
        newConstraint.priority = constraint.priority
        newConstraint.shouldBeArchived = constraint.shouldBeArchived
        newConstraint.identifier = constraint.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        constraint = newConstraint
    }
    
    static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: constraint.firstItem ?? "",
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: multiplier,
            constant: constraint.constant)
        
        newConstraint.priority = constraint.priority
        
        NSLayoutConstraint.deactivate([constraint])
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
    
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}


extension UIFont {
    
    public enum ProximanovaType: String {
        case light = "light"
        case regular = "regular"
        case bold = "bold"
        case semibold = "semibold"
    }
    
    public enum OpensansType: String {
        case light    =   "Light"
        case regular  =   "Regular"
        case bold     =   "Bold"
        case semibold =   "SemiBold" //SemiBold
        case medium   =   "Medium"
    }
    
    static func Font_Proximanova(_ type: ProximanovaType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "proximanova-\(type.rawValue)", size: size) ?? (UIFont(name: "ProximaNova-\(type.rawValue)", size: size) ?? .systemFont(ofSize: size, weight: .regular))!
    }
    
    static func Font_Opensans(_ type: OpensansType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "OpenSans-\(type.rawValue)", size: size) ?? (UIFont(name: "OpenSans-\(type.rawValue)", size: size) ?? .systemFont(ofSize: size, weight: .regular))!
    }
}


extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func checkForDashboardViewController() -> DashboardVC? {
        guard let dashboardVC = self.topViewController()?.navigationController?.viewControllers.first(where: { $0 is DashboardVC }) as? DashboardVC else {
            print("DashboardVC is not in the navigation stack.")
            return nil
        }
        return dashboardVC
    }
    
    fileprivate var keyWindowWithoutInactive: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    class func topViewControllerWithoutInactive(controller: UIViewController? = UIApplication.shared.keyWindowWithoutInactive?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


extension UINavigationController {
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func adjustedForShareSheetPreviewIconProvider() -> UIImage {
        let replaceTransparencyWithColor = UIColor.black // change as required
        let minimumSize: CGFloat = 40.0  // points
        
        let format = UIGraphicsImageRendererFormat.init()
        format.opaque = true
        format.scale = self.scale
        
        let imageWidth = self.size.width
        let imageHeight = self.size.height
        let imageSmallestDimension = max(imageWidth, imageHeight)
        let deviceScale = UIScreen.main.scale
        let resizeFactor = minimumSize * deviceScale  / (imageSmallestDimension * self.scale)
        
        let size = resizeFactor > 1.0
        ? CGSize(width: imageWidth * resizeFactor, height: imageHeight * resizeFactor)
        : self.size
        
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            let size = context.format.bounds.size
            replaceTransparencyWithColor.setFill()
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIColor{
    
    func randomColor() -> (UIColor , UIColor) {
        // Generate random values for red, green, and blue components
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        // Create a UIColor object using the random values
        let darlcolor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        let Lightcolor = UIColor(red: red, green: green, blue: blue, alpha: 0.5)
        return (darlcolor,Lightcolor)
    }
    
}

extension Data {
    init?(hex: String) {
        var hexString = hex
        if hex.count % 2 != 0
        {
            hexString = "0\(hex)"
        }
        let len = hexString.count / 2
        var data = Data(capacity: len)
        
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        
        self = data
    }
}

extension FixedWidthInteger {
    var data: Data {
        var value = self
        return Data(bytes: &value, count: MemoryLayout<Self>.size)
    }
}

//MARK: Change
extension UILabel{
    
    func setTitleAndDescription(
        title: String,
        description: String,
        titleFontSize: CGFloat = 18,
        descriptionFontSize: CGFloat = 18,
        textColor: UIColor = UIColor(named: "#33B6E4") ?? .black
    ) {
        // Ensure Poppins fonts are available
        let titleFont = UIFont(name: "Poppins-Bold", size: titleFontSize) ?? UIFont.boldSystemFont(ofSize: titleFontSize)
        let descriptionFont = UIFont(name: "Poppins-Regular", size: descriptionFontSize) ?? UIFont.systemFont(ofSize: descriptionFontSize)
        
        // Attributes for the title (bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        
        // Attributes for the description (regular)
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .font: descriptionFont
        ]
        
        // Create attributed strings for title and description
        let attributedText = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let descriptionText = NSAttributedString(string: " \(description)", attributes: descriptionAttributes)
        
        // Append description to the title
        attributedText.append(descriptionText)
        
        // Set the attributed text and color
        self.attributedText = attributedText
        self.textColor = textColor
    }
}
