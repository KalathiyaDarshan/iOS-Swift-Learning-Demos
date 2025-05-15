//
//  Gesture.swift
//  GestareRecognizerDemo
//
//  Created by mac on 13/09/24.
//

import Foundation
import UIKit

class GestureProperty{
    var name: String
    var viewColor: UIColor
    var gestureType: UIGestureRecognizer
    
    init(name: String,viewColor: UIColor,gestureType: UIGestureRecognizer) {
        self.name = name
        self.viewColor = viewColor
        self.gestureType = gestureType
    }
}
