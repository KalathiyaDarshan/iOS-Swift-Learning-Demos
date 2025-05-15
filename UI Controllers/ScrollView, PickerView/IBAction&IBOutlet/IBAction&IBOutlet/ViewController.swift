//
//  ViewController.swift
//  IBAction&IBOutlet
//
//  Created by mac on 23/05/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
    @IBOutlet var lblName: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var btnName: UIButton!
    @IBOutlet var btnSwitch: UISwitch!
    
    var data = ["One","Two","Three","Four","Five"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        btnName.setTitle("okk", for: .normal)
       // btnName.setBackgroundImage(UIImage(named: "Image"), for: .normal)
        btnName.setImage(UIImage(named: "Image"), for: .normal)
      
      // btnName.setTitleColor(UIColor.green, for: .normal)
        print(btnName.currentTitle)
        print(btnName.currentImage)
        print(btnName.currentTitleColor)
        print(btnName.currentBackgroundImage)
      //  print(btnName.currentAttributedTitle)
        btnName.backgroundColor = UIColor.green
        
        btnName.semanticContentAttribute = .forceRightToLeft
        btnName.imageEdgeInsets = UIEdgeInsets(top: 0, left: btnName.titleEdgeInsets.left, bottom: 0, right: -btnName.titleLabel!.bounds.width)
        btnName.titleEdgeInsets = UIEdgeInsets(top: 0, left: -btnName .imageView!.bounds.width, bottom: 0, right: 0)
        btnSwitch.onImage = UIImage(named: "Image")
        pickerView.dataSource = self
        pickerView.delegate = self
        btnName.attributedTitle(for: .normal)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
   }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = data[row]
               print("Selected: \(selectedOption)")
    }

    @IBAction func ActionTouchUp(_ sender: UIButton) {
        print(#function)
    }
    
    @IBAction func ActionValueChange(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if sender.isOn{
            print("Switch is on")
            if let onImage = UIImage(systemName: "trash") {
                sender.onImage = onImage
                print("Image set for 'on' state")
            } else {
                print("Failed to load image")
            }
        }
        else{
            print("Switch is off")
        }
    }
    @IBAction func ActionUpOut(_ sender: UIButton) {
        print(#function)
    }
}

