//
//  PlaceHolderTextView.swift
//  BLEScanner
//
//  Created by apple on 27/06/24.
//

import Foundation
import UIKit

//extension UITextView {
//
//    private class PlaceholderLabel: UILabel { }
//
//    private var placeholderLabel: PlaceholderLabel {
//        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
//            return label
//        } else {
//            let label = PlaceholderLabel(frame: .zero)
//            label.font = font
//            addSubview(label)
//            return label
//        }
//    }
//
//    @IBInspectable
//    var placeholder: String {
//        get {
//            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
//        }
//        set {
//            let placeholderLabel = self.placeholderLabel
//            placeholderLabel.text = newValue
//            placeholderLabel.numberOfLines = 0
//            let width = frame.width - textContainer.lineFragmentPadding * 2
//            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
//            placeholderLabel.frame.size.height = size.height
//            placeholderLabel.frame.size.width = width
//            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)
//
//            textStorage.delegate = self
//        }
//    }
//
//}
//
//extension UITextView: NSTextStorageDelegate {
//
//    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
//        if editedMask.contains(.editedCharacters) {
//            placeholderLabel.isHidden = !text.isEmpty
//        }
//    }
//
//}
