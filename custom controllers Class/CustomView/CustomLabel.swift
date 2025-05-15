//
//  CustomView.swift
//  BLEHealth+
//
//  Created by Bluepixel.
//  Copyright © Bluepixel Technologies. All rights reserved.
//

import UIKit


@IBDesignable
class CustomLabel: UILabel {
    
    @IBInspectable var localizerStringtext: String = "" {
        didSet {
            self.text = objLocalizeUtils.stringForKey(key: localizerStringtext)
        }
    }
    
    @IBInspectable var IsRound: Bool = false {
        didSet{
            if IsRound {
                layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
            }
        }
    }
    
    @IBInspectable var IsRoundCorner: Bool = false {
        didSet{
            if IsRoundCorner {
                layer.cornerRadius = (layer.frame.size.height) / 2
            }
        }
    }
    
    @IBInspectable var BordeHeight: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = BordeHeight
        }
    }
    
    @IBInspectable var BordeColor: UIColor = .clear {
        didSet {
            layer.borderColor = BordeColor.cgColor
        }
    }
    
    @IBInspectable var marktxtColor: UIColor = .clear {
        didSet {
            self.textColor = textColor
        }
    }
    
    @IBInspectable var CornerRadius: CGFloat = 0{
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var markText: String = "" {
        didSet {
            let strPlaceholder:NSString = self.text! as NSString
            let range = strPlaceholder.range(of: self.markText)
            
            let attributedText =
            NSMutableAttributedString(string: strPlaceholder as String)
            
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: marktxtColor , range: range)
            
            self.attributedText = attributedText
            
            self.layoutIfNeeded()
        }
        
    }
    
    @IBInspectable var AutoSizeFont: Bool = false {
        didSet {
            if AutoSizeFont {
                font = UIFont(name: (font.fontName), size: DeviceManager.GetAutoFontSize(minFontZie: (font.pointSize)))
            }
        }
    }
    
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    @IBInspectable var rotation: Int = 0 {
        didSet {
            if rotation != 0 {
                let radians = CGFloat(CGFloat(Double.pi) * CGFloat(rotation) / CGFloat(180.0))
                self.transform = CGAffineTransform(rotationAngle: radians)
            }
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if IsRound {
            layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
        }
        
        if IsRoundCorner {
            layer.cornerRadius = (layer.frame.size.height) / 2
        }
        
        if rotation != 0 {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(rotation) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}
