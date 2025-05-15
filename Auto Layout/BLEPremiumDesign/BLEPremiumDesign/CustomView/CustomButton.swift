//
//  CustomView.swift
//  BLEHealth+
//
//  Created by Bluepixel.
//  Copyright © Bluepixel Technologies. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var localizerStringtext: String = "" {
        didSet {
           // self.setTitle(objLocalizeUtils.stringForKey(key: localizerStringtext), for: .normal)
        }
    }
    
    @IBInspectable var localizerSelectedStringText: String = "" {
        didSet {
            //self.setTitle(objLocalizeUtils.stringForKey(key: localizerStringtext), for: .selected)
        }
    }
    
    @IBInspectable var IsRound: Bool = false {
        didSet{
            if IsRound {
                layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
                //                layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var IsRoundCorner: Bool = false {
        didSet{
            if IsRoundCorner {
                layer.cornerRadius = (layer.frame.size.height) / 2
                //                layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = CornerRadius
            //            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var BordeHeight: CGFloat = 0.0 {
        didSet{
            
            layer.borderWidth = BordeHeight
        }
    }
    @IBInspectable var BordeColor: UIColor = .clear {
        didSet{
            layer.borderColor = BordeColor.cgColor
        }
    }
    
    @IBInspectable var ShadowColor: UIColor = .clear {
        didSet{
            layer.shadowColor = ShadowColor.cgColor
        }
    }
    @IBInspectable var ShadowRadius: CGFloat = 0.0 {
        didSet{
            layer.shadowRadius = ShadowRadius
            layer.masksToBounds = false
        }
    }
    @IBInspectable var ShadowOpacity: CGFloat = 0.0 {
        didSet{
            layer.shadowOpacity = Float(ShadowOpacity)
        }
    }
    @IBInspectable var ShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = ShadowOffset
        }
    }
    @IBInspectable var AutoSizeFont: Bool = false {
        didSet {
            if AutoSizeFont {
                titleLabel?.font = UIFont(name: (titleLabel?.font.fontName)!, size: DeviceManager.GetAutoFontSize(minFontZie: (titleLabel?.font.pointSize)!))
            }
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
    }
}
