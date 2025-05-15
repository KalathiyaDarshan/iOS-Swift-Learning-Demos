//
//  SegmentViewController.swift
//  UiController
//
//  Created by mac on 27/05/24.
//

import UIKit

class SegmentViewController: UIViewController {

    @IBOutlet var SegmentController: UISegmentedControl!
    @IBOutlet var ViewColor: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewColor.backgroundColor = UIColor.yellow
       // SegmentController.selectedSegmentIndex = 2
       // SegmentController.backgroundColor = .purple
       // SegmentController.selectedSegmentTintColor = .brown
      //  SegmentController.setTitle("First View", forSegmentAt: 0)
      //  SegmentController.setWidth(, forSegmentAt: 1)
        }

    @IBAction func ChangeSegmnetValue(_ sender: UISegmentedControl) {
        switch SegmentController.selectedSegmentIndex {
            case 0:
                ViewColor.backgroundColor = UIColor.yellow
            case 1:
                ViewColor.backgroundColor = UIColor.green
            case 2:
                ViewColor.backgroundColor = UIColor.gray
            default:
                break
        }
    }
    
}
