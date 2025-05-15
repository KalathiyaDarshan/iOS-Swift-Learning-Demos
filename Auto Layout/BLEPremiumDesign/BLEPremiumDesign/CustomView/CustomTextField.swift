//
//  CustomView.swift
//  BLEHealth+
//
//  Created by Bluepixel.
//  Copyright © Bluepixel Technologies. All rights reserved.
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var localizerStringtext: String = "" {
        didSet {
          //  self.text = objLocalizeUtils.stringForKey(key: localizerStringtext)
        }
    }
    
    @IBInspectable var localizerPlaceholderStringtext: String = "" {
        didSet {
          //  self.placeholder = objLocalizeUtils.stringForKey(key: localizerPlaceholderStringtext)
        }
    }
    
    @IBInspectable var IsRound: Bool = false {
        didSet{
            if IsRound {
                layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
                layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var IsRoundCorner: Bool = false {
        didSet{
            if IsRoundCorner {
                layer.cornerRadius = (layer.frame.size.height) / 2
                layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = CornerRadius
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var AutoSizeFont: Bool = false {
        didSet {
            if AutoSizeFont {
                font = UIFont(name: (font?.fontName ?? "")!, size: DeviceManager.GetAutoFontSize(minFontZie: (font?.pointSize ?? 0)!))
            }
        }
    }
    
    @IBInspectable var BordeHeight: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = BordeHeight
        }
    }
    
    @IBInspectable var LeftPadding: CGFloat = 0.0 {
        didSet {
            let leftview = UIView(frame: CGRect(x: 0, y: 0, width: Int(LeftPadding), height: Int(frame.size.height)))
            leftView = leftview
            leftViewMode = .always
        }
    }
    @IBInspectable var RightPadding: CGFloat = 0.0 {
        didSet {
            let rightview = UIView(frame: CGRect(x: 0, y: 0, width: Int(LeftPadding), height: Int(frame.size.height)))
            rightView = rightview
            rightViewMode = .always
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder!: "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor!])
        }
    }
    
    @IBInspectable var CursorColor: UIColor? {
        didSet {
            self.tintColor = CursorColor
        }
    }
    
    @IBInspectable var BordeColor: UIColor = UIColor.black {
        didSet{
            layer.borderColor = BordeColor.cgColor
        }
    }
    
    @IBInspectable var bottomBorderHeight: CGFloat = 0.0
    @IBInspectable var bottomBorderColor: UIColor = .clear
    
    @IBInspectable var topBorderHeight: CGFloat = 0.0
    @IBInspectable var topBorderColor: UIColor = .clear
    
    @IBInspectable var leftBorderHeight: CGFloat = 0.0
    @IBInspectable var leftBorderColor: UIColor = .clear
    
    @IBInspectable var rightBorderHeight: CGFloat = 0.0
    @IBInspectable var rightBorderColor: UIColor = .clear
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bottomBorderHeight > 0 {
            
            let label = UILabel()
            label.backgroundColor = bottomBorderColor
            //            label.layer.cornerRadius = CornerRadius
            label.frame = CGRect(x: 0, y: self.bounds.size.height - bottomBorderHeight, width: self.bounds.size.width, height: bottomBorderHeight)
            
            addSubview(label)
            
        }
        
        if topBorderHeight > 0 {
            
            let label = UILabel()
            label.backgroundColor = topBorderColor
            //            label.layer.cornerRadius = CornerRadius
            label.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: topBorderHeight)
            
            addSubview(label)
            
        }
        
        if leftBorderHeight > 0 {
            
            let label = UILabel()
            label.backgroundColor = leftBorderColor
            //            label.layer.cornerRadius = CornerRadius
            label.frame = CGRect(x: 0, y: 0, width: leftBorderHeight, height: bounds.size.height)
            
            addSubview(label)
        }
        
        if rightBorderHeight > 0 {
            
            let label = UILabel()
            label.backgroundColor = rightBorderColor
            //            label.layer.cornerRadius = CornerRadius
            label.frame = CGRect(x: bounds.size.width - rightBorderHeight, y: 0, width: rightBorderHeight, height: bounds.size.height)
            
            addSubview(label)
        }
        
        if #available(iOS 13.0, *) {
            self.traitCollection.performAsCurrent {
                layer.borderColor = BordeColor.cgColor
            }
        }
        
        if IsRound {
            layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
            layer.masksToBounds = false
        }
        
        if IsRoundCorner {
            layer.cornerRadius = (layer.frame.size.height) / 2
            layer.masksToBounds = false
        }
    }
}
