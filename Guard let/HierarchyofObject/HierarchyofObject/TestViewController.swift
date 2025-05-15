//
//  TestViewController.swift
//  HierarchyofObject
//
//  Created by mac on 21/05/24.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet var txtTestName: UITextField!
    @IBOutlet var switchStatus: UISwitch!
    @IBOutlet var percentage: UITextField!
    
    var arrTeacherTest = [Teacher]()
    var studLastIndex = Int()
    var indexLastOfTeacher = Int()
    var switchValue = String()
    
    var testDelegate: TestDataPassProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    @IBAction func AddTest(_ sender: Any) {
        if switchStatus.isOn == true{
            switchValue = "Pass"
        }
        else {
            switchValue = "Fial"
        }
        
        let objtest = Test(testName: txtTestName.text ?? "", percentage: Int(percentage.text ?? "") ?? 0, sta:  switchValue)
      
        arrTeacherTest[indexLastOfTeacher].student[studLastIndex].test.append(objtest)
        txtTestName.text = ""
        percentage.text = ""
        switchStatus.isOn = false
         
       }
    
    @IBAction func ActionResult(_ sender: Any) {
          let ResultVc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        ResultVc.arrMain = arrTeacherTest
         navigationController?.pushViewController(ResultVc, animated: true)
    
    }
    
    @IBAction func BacktoStudent(_ sender: Any) {
        testDelegate?.TestData(TestName: arrTeacherTest[indexLastOfTeacher].student[studLastIndex].test)
        navigationController?.popViewController(animated: true)
    }
    

}
enum status:String {
    case pass = "Pass"
    case fail = "Fail"
}

protocol TestDataPassProtocol {
    func TestData(TestName: [Test])
}

