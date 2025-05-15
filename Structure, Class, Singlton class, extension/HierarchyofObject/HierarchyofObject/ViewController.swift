//
//  ViewController.swift
//  HierarchyofObject
//
//  Created by mac on 21/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    var stud = [Students]()
  
    @IBOutlet var txtTeacerName: UITextField!
    @IBOutlet var TxtSubject: UITextField!
    @IBOutlet var btnAddTeacher: UIButton!
    
    var arryobj = [Teacher]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func AddStudent(_ sender: Any) {
       
        let obj = Teacher(teacher: txtTeacerName.text ?? "", subject: Int(TxtSubject.text!) ?? 0, student: stud)
        arryobj.append(obj)
        
        let nextVc = storyboard?.instantiateViewController(identifier: "StudentViewController") as! StudentViewController
        nextVc.Arrayobj = arryobj
        nextVc.arrayLastIndex = arryobj.count - 1
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        txtTeacerName.text = ""
        TxtSubject.text = ""
    }
}
enum Subjects: Int{
    case Python = 1
    case java = 2
    case Swift = 3
}

class Teacher{
    var teacher:String
    var subject:Subjects
    var student:[Students]
    
    init(teacher:String ,subject:Int ,student:[Students]) {
        self.teacher = teacher
        self.subject = Subjects(rawValue: subject) ?? .Python
        self.student = student
    }
}
class  Students {
    var Studentname: String
    var RollNumber: Int
    var test:[Test]
   
    init(Student: String,RollNumber:Int,test:[Test]) {
        self.Studentname = Student
        self.RollNumber = RollNumber
        self.test = test
    }
}

class Test{
    var testName: String
    var percentage: Int
    var sta: status
    init(testName: String, percentage: Int, sta:Int) {
        self.testName = testName
        self.percentage = percentage
        self.sta = status(rawValue: sta) ?? .fail
    }
}
