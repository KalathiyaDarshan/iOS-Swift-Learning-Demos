//
//  ReadMoreLableButton.swift
//  UBFit
//
//  Created by Rakesh Jiyani on 28/12/21.
//

import UIKit

class ReadMoreLableButton: UILabel {
    
    var isExpaded = false
    var minLineToDisplay: Int = 2
    var button = UIButton(frame: CGRect(x: 0, y: 10, width: 70, height: 35))
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let buttonAray =  self.superview?.subviews.filter({ (subViewObj) -> Bool in
            return subViewObj.tag ==  9090
        })
        
        if buttonAray?.isEmpty == true {
            self.addReadMoreButton()
        }
    }
    
    //Add readmore button in the label.
    func addReadMoreButton() {
        
        let theNumberOfLines = numberOfLinesInLabel(yourString: self.text ?? "", labelWidth: self.frame.width, labelHeight: self.frame.height, font: self.font)
        
        let height = self.frame.height
        self.numberOfLines =  self.isExpaded ? 0 : self.minLineToDisplay
        
        
        if theNumberOfLines > self.minLineToDisplay {
            
            self.numberOfLines = self.minLineToDisplay
            button = UIButton(frame: CGRect(x: 0, y: height+10, width: 70, height: 35))
            button.tag = 9090
            button.frame = self.frame
            button.frame.origin.y =  self.frame.origin.y  +  self.frame.size.height + 15
            button.setTitle("Read More", for: .normal)
            button.titleLabel?.font = button.titleLabel?.font.withSize(15)
            button.backgroundColor = .clear
            button.setTitleColor(UIColor(hexString: "#8DB10E"), for: .normal)
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
            self.superview?.addSubview(button)
            self.superview?.bringSubviewToFront(button)
            button.setTitle("Read Less", for: .selected)
            button.isSelected = self.isExpaded
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                button.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: +25)
            ])
            
        } else {
            self.numberOfLines = self.minLineToDisplay
        }
    }
    
    
    
    //ReadMore Button Action
    @objc func buttonTapped(sender : UIButton) {
        
        self.isExpaded = !isExpaded
        sender.isSelected = self.isExpaded
        
        self.numberOfLines =  sender.isSelected ? 0 : self.minLineToDisplay
        
        self.layoutIfNeeded()
        
        var viewObj :UIView?  = self
        var cellObj :UITableViewCell?
        while viewObj?.superview != nil  {
            
            if let cell = viewObj as? UITableViewCell  {
                
                cellObj = cell
            }
            
            if let tableView = (viewObj as? UITableView)  {
                
                if let indexPath = tableView.indexPath(for: cellObj ?? UITableViewCell()){
                    
                    tableView.beginUpdates()
                    print(indexPath)
                    tableView.endUpdates()
                    
                }
                return
            }
            viewObj = viewObj?.superview
        }
    }
}
extension UIView {
    //Calculating the number of lines. -> Int
    func numberOfLinesInLabel(yourString: String, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = labelHeight
        paragraphStyle.maximumLineHeight = labelHeight
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font, NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue): paragraphStyle]
        
        let constrain = CGSize(width: labelWidth, height: CGFloat(Float.infinity))
        
        let size = yourString.size(withAttributes: attributes)
        
        let stringWidth = size.width
        
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        
        return Int(numberOfLines)
    }
}
