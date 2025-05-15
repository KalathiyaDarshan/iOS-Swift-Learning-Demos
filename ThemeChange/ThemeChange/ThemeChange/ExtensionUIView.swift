//
//  ExtensionUIView.swift
//  ThemeChange
//
//  Created by Darshan Kalathiya on 18/12/24.
//

import Foundation
import UIKit

extension UIView {
    
    func setupGradientColors(
        firstGradientColor: UIColor,
        secondGradientColor: UIColor
    ) {
        
        // Remove existing gradient layers to avoid stacking
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        
        let colors = [firstGradientColor, secondGradientColor].map { $0.cgColor }
        
        // Determine light/dark mode
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        
        gradientLayer.colors = colors
        
        // Set direction based on mode
        gradientLayer.startPoint = isDarkMode
        ? CGPoint(x: 0.5, y: 0) // Top to bottom for dark mode
        : CGPoint(x: 0, y: 0.5) // Left to right for light mode
        gradientLayer.endPoint = isDarkMode
        ? CGPoint(x: 0.5, y: 1)
        : CGPoint(x: 1, y: 0.5)
        
        gradientLayer.frame = self.bounds
        gradientLayer.zPosition = -1
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

