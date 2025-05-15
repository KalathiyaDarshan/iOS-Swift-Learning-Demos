//
//  StudentViewController.swift
//  HierarchyofObject
//
//  Created by mac on 21/05/24.
//

import UIKit

class StudentViewController: UIViewController {

    var tst = [Test]()
    
    var studentDelegate : StudentDataPassProtocol?
    
    @IBOutlet var txtRollnumber: UITextField!
    @IBOutlet var txtStudentName: UITextField!
   
    var Arrayobj = [Teacher]()
    var arrayLastIndex = Int()
     override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    @IBAction func AddStudent(_ sender: Any) {
        let studnts = Students.init(Student: txtStudentName.text ?? "", RollNumber: Int(txtRollnumber.text ?? "") ?? 0, test: tst)
        
        Arrayobj[arrayLastIndex].student.append(studnts)
      
        let testVc = storyboard?.instantiateViewController(identifier: "TestViewController") as? TestViewController
           testVc?.arrTeacherTest = Arrayobj
        testVc?.studLastIndex = Arrayobj[arrayLastIndex].student.count - 1
        testVc?.indexLastOfTeacher = arrayLastIndex
        testVc?.testDelegate = self
            navigationController?.pushViewController(testVc!, animated: true)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        txtRollnumber.text = ""
        txtStudentName.text = ""
    }
}
// MARK:UINavigationControllerDelegate
extension StudentViewController : UINavigationControllerDelegate
{
    // Implement the delegate method
       func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
           // Check if the view controller being shown is not the current one
        if viewController == self.navigationController?.viewControllers.first {
               // The back button was pressed
                studentDelegate?.StudentDataFetched(arrStudents: Arrayobj[arrayLastIndex].student)
               // Perform any actions needed before the view controller is popped
           }
       }
}

protocol StudentDataPassProtocol{
     func StudentDataFetched(arrStudents: [Students])
}

extension StudentViewController: TestDataPassProtocol{
    func TestData(TestName: [Test]) {
        print(TestName.count)
        for test in TestName {
            print(test.testName)
        }
    }
    
    
}
