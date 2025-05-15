//
//  ViewController.swift
//  HierarchyofObject
//
//  Created by mac on 21/05/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var stud = [Students]()
  
    @IBOutlet var txtTeacerName: UITextField!
    @IBOutlet var TxtSubject: UITextField!
    @IBOutlet var btnAddTeacher: UIButton!
    let pickerView = UIPickerView()
    var arryobj = [Teacher]()
  var subjectData = ["Python", "Java" , "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtSubject.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        TxtSubject.inputView = pickerView
        
         }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjectData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TxtSubject.text = subjectData[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
   

    @IBAction func AddStudent(_ sender: Any) {
       
        let obj = Teacher(teacher: txtTeacerName.text ?? "", subject: TxtSubject.text!, student: stud)
        arryobj.append(obj)
        
        let nextVc = storyboard?.instantiateViewController(identifier: "StudentViewController") as! StudentViewController
        nextVc.studentDelegate = self
        nextVc.Arrayobj = arryobj
        nextVc.arrayLastIndex = arryobj.count - 1
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        txtTeacerName.text = ""
        TxtSubject.text = ""
        pickerView.selectRow(0, inComponent: 0, animated: true)
    }
}
enum Subjects: String{
    case Python = "Python"
    case java = "Java"
    case Swift = "Swift"
}

class Teacher{
    var teacher:String
    var subject:Subjects
    var student:[Students]
    
    init(teacher:String ,subject:String ,student:[Students]) {
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
    init(testName: String, percentage: Int, sta:String) {
        self.testName = testName
        self.percentage = percentage
        self.sta = status(rawValue: sta) ?? .fail
    }
}

extension ViewController : StudentDataPassProtocol
{
    func StudentDataFetched(arrStudents: [Students]) {
        print(arrStudents.count)
        for item in arrStudents {
            print(item.Studentname)
        }
    }
}
