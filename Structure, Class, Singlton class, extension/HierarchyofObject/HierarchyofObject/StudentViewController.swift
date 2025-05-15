//
//  StudentViewController.swift
//  HierarchyofObject
//
//  Created by mac on 21/05/24.
//

import UIKit

class StudentViewController: UIViewController {

    var tst = [Test]()
    @IBOutlet var txtRollnumber: UITextField!
    @IBOutlet var txtStudentName: UITextField!
   
    var Arrayobj = [Teacher]()
    var arrayLastIndex = Int()
     override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func AddStudent(_ sender: Any) {
        let studnts = Students.init(Student: txtStudentName.text ?? "", RollNumber: Int(txtRollnumber.text ?? "") ?? 0, test: tst)
        
        Arrayobj[arrayLastIndex].student.append(studnts)
       print(arrayLastIndex)
        
            let testVc = storyboard?.instantiateViewController(identifier: "TestViewController") as? TestViewController
           testVc?.objtest1 = Arrayobj
        testVc?.studLastIndex = Arrayobj[arrayLastIndex].student.count - 1
        testVc?.indexLastOfTeacher = arrayLastIndex
            navigationController?.pushViewController(testVc!, animated: true)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        txtRollnumber.text = ""
        txtStudentName.text = ""
    }
}
