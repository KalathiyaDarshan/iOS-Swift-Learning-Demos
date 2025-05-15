//
//  CustomTextView.swift
//  BLEHealth+
//
//  Created by Bluepixel.
//  Copyright © Bluepixel Technologies. All rights reserved.
//

import UIKit

private var kAssociationKeyMaxLengthTextView: Int = 0

extension UITextView {
    
    @IBInspectable var CornerRadius: CGFloat  {
        get {
            return layer.cornerRadius
        }
        set {
            return layer.cornerRadius  = newValue
        }
    }
}

@IBDesignable
class CustomTextView: UITextView, UITextViewDelegate {
    
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
    
    @IBInspectable var BordeHeight: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = BordeHeight
        }
    }
    
    @IBInspectable var BordeColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = BordeColor.cgColor
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor = .lightGray {
        didSet {
            self.textColor = placeHolderColor
        }
    }
    
    @IBInspectable var textfiledColor: UIColor = .black {
        didSet {
            //           self.textColor = textfiledColor
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            self.delegate = self
            self.text = placeholder
        }
    }
    
    @IBInspectable var AutoSizeFont: Bool = false {
        didSet {
            if AutoSizeFont {
                font = UIFont(name: (font?.fontName)!, size: DeviceManager.GetAutoFontSize(minFontZie: (font?.pointSize)!))
            }
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLengthTextView) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            self.delegate = self
            
            objc_setAssociatedObject(self, &kAssociationKeyMaxLengthTextView, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    @objc func checkMaxLength(textView: UITextView) {
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
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty{
            self.text = placeholder
            self.textColor = placeHolderColor
            self.resignFirstResponder()
        } else {
            
            if self.textColor == placeHolderColor {
                self.text = ""
            }
            self.textColor = self.textfiledColor
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.text = placeholder
            self.textColor = placeHolderColor
            
        } else {
            
            if self.textColor == placeHolderColor {
                self.text = ""
            }
            self.becomeFirstResponder()
            self.textColor = self.textfiledColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.delegate = self
        
        if IsRound {
            layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
            layer.masksToBounds = false
        }
        
        if IsRoundCorner {
            layer.cornerRadius = (layer.frame.size.height) / 2
            layer.masksToBounds = false
        }
        
        if #available(iOS 13.0, *) {
            self.traitCollection.performAsCurrent {
                layer.borderColor = BordeColor.cgColor
            }
        }
    }
}
