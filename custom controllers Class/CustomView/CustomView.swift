//
//  CustomView.swift
//  BLEHealth+
//
//  Created by Bluepixel.
//  Copyright © Bluepixel Technologies. All rights reserved.

import UIKit

@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var IsRound: Bool = false {
        didSet {
            if IsRound {
                layer.cornerRadius = (layer.frame.size.width + layer.frame.size.height) / 4
            }
        }
    }
    
    @IBInspectable var IsRoundCorner: Bool = false {
        didSet {
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
    
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var ShadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = ShadowColor.cgColor
        }
    }
    
    @IBInspectable var ShadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = ShadowRadius
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var ShadowOpacity: CGFloat = 0.0 {
        didSet {
            layer.shadowOpacity = Float(ShadowOpacity)
        }
    }
    
    @IBInspectable var ShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = ShadowOffset
        }
    }
    
    @IBInspectable var topLeftRightCornerRadius: CGFloat = 0.0
    @IBInspectable var topLeftBottomLeftCornerRadius: CGFloat = 0.0
    @IBInspectable var topRightBottomRightCornerRadius: CGFloat = 0.0
    @IBInspectable var topRightCornerRadius: CGFloat = 0.0
    @IBInspectable var topLeftCornerRadius: CGFloat = 0.0
    @IBInspectable var bottomRightCornerRadius: CGFloat = 0.0
    @IBInspectable var bottomLeftCornerRadius: CGFloat = 0.0
    
    @IBInspectable var firstGradientColor: UIColor? = nil {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondGradientColor: UIColor? = nil {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    private var shadowLayer: CAShapeLayer?
    
    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        if firstGradientColor != nil, secondGradientColor != nil {
            layer.colors = [firstGradientColor!, secondGradientColor!].map{$0.cgColor}
            if (self.isHorizontal) {
                layer.startPoint = CGPoint(x: 0, y: 0.5)
                layer.endPoint = CGPoint (x: 1, y: 0.5)
                
            } else {
                layer.startPoint = CGPoint(x: 0.5, y: 0)
                layer.endPoint = CGPoint (x: 0.5, y: 1)
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
        
        if topLeftRightCornerRadius > 0.0 {
            
            roundCorners(corners: [.topLeft, .topRight], radius: topLeftRightCornerRadius)
        }
        
        if topLeftBottomLeftCornerRadius > 0.0 {
            
            roundCorners(corners: [.topLeft, .bottomLeft], radius: topLeftBottomLeftCornerRadius)
        }
        
        if topRightBottomRightCornerRadius > 0.0 {
            
            roundCorners(corners: [.topRight, .bottomRight], radius: topRightBottomRightCornerRadius)
        }
        
        if topRightCornerRadius > 0.0 {
            
            roundCorners(corners: [.topRight], radius: topRightCornerRadius)
        }
        
        if topLeftCornerRadius > 0.0 {
            
            roundCorners(corners: [.topLeft], radius: topLeftCornerRadius)
        }
        
        if bottomRightCornerRadius > 0.0 {
            
            roundCorners(corners: [.bottomRight], radius: bottomRightCornerRadius)
        }
        
        if bottomLeftCornerRadius > 0.0 {
            
            roundCorners(corners: [.bottomLeft], radius: bottomLeftCornerRadius)
        }
    }
    
    fileprivate func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    @IBInspectable
    /// Border width of view; also inspectable from Storyboard.
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
