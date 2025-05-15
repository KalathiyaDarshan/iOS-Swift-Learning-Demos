//
//  ViewController.swift
//  AttributedLabelWithLink
//
//  Created by Darshan Kalathiya on 31/12/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblDetail.setupLabel(regularText:  "Visit", attributed1: "Google", link1: "https://www.google.com", attributed2: "Apple", link2: "https://www.apple.com")
    }


    

}

extension UILabel {
    func setupLabel(regularText: String,
                    attributed1: String,
                    link1: String,
                    attributed2: String,
                    link2: String) {
        let fullText = "\(regularText) \(attributed1) and \(attributed2)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Set regular text color
        let regularRange = NSRange(location: 0, length: regularText.count)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: regularRange)
        
        // Add attributes for the first link
        if let range1 = fullText.range(of: attributed1) {
            let nsRange1 = NSRange(range1, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.link, range: nsRange1)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange1)
            attributedString.addAttribute(.link, value: link1, range: nsRange1)
        }
        
        // Add attributes for the second link
        if let range2 = fullText.range(of: attributed2) {
            let nsRange2 = NSRange(range2, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.link, range: nsRange2)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange2)
            attributedString.addAttribute(.link, value: link2, range: nsRange2)
        }
        
        // Set the attributed text
        self.attributedText = attributedString
        self.isUserInteractionEnabled = true
        
        // Add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel,
              let attributedText = label.attributedText,
              let _ = label.text else { return }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let location = sender.location(in: label)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        
        let boundingRect = layoutManager.boundingRect(forGlyphRange: NSRange(location: 0, length: layoutManager.numberOfGlyphs), in: textContainer)
        let adjustedLocation = CGPoint(x: location.x - (label.bounds.width - boundingRect.width) / 2,
                                       y: location.y - (label.bounds.height - boundingRect.height) / 2)
        
        let characterIndex = layoutManager.glyphIndex(for: adjustedLocation, in: textContainer)
        if characterIndex < textStorage.length {
            let attribute = textStorage.attribute(.link, at: characterIndex, effectiveRange: nil)
            if let urlString = attribute as? String, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}
