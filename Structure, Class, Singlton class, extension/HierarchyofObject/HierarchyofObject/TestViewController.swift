//
//  TestViewController.swift
//  HierarchyofObject
//
//  Created by mac on 21/05/24.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet var txtTestName: UITextField!
    @IBOutlet var txtStatus: UITextField!
    @IBOutlet var percentage: UITextField!
    
    var objtest1 = [Teacher]()
    var studLastIndex = Int()
    var indexLastOfTeacher = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func AddTest(_ sender: Any) {
        let objtest = Test(testName: txtTestName.text ?? "", percentage: Int(percentage.text ?? "") ?? 0, sta: Int(txtStatus.text ?? "") ?? 0)
      
        objtest1[indexLastOfTeacher].student[studLastIndex].test.append(objtest)
        print(studLastIndex)
        txtTestName.text = ""
        percentage.text = ""
        txtStatus.text = ""
        
       }
    
    @IBAction func ActionResult(_ sender: Any) {
          let ResultVc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        ResultVc.objmain = objtest1
         navigationController?.pushViewController(ResultVc, animated: true)
    
    }
    
    @IBAction func BacktoStudent(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
enum status:Int {
    case pass = 1
    case fail = 2
}
