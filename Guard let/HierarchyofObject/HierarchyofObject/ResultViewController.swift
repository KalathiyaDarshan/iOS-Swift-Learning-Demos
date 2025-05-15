
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var lblTeacher1: UILabel!
    @IBOutlet var Subject1: UILabel!
    @IBOutlet var lblTeacher2: UILabel!
    @IBOutlet var Subject2: UILabel!
    
    @IBOutlet var lblStudent1: UILabel!
    @IBOutlet var lblStudent2: UILabel!
    @IBOutlet var lblStudent21: UILabel!
    @IBOutlet var lblStudent22: UILabel!
    
    
    @IBOutlet var lblRoll1: UILabel!
    @IBOutlet var lblRoll2: UILabel!
    @IBOutlet var lblRoll21: UILabel!
    @IBOutlet var lblRoll22: UILabel!
    
    @IBOutlet var lblTest1: UILabel!
    @IBOutlet var lblTest2: UILabel!
    @IBOutlet var lblTest21: UILabel!
    @IBOutlet var lblTest22: UILabel!
    @IBOutlet var lblTest211: UILabel!
    @IBOutlet var lblTest212: UILabel!
    @IBOutlet var lblTest221: UILabel!
    @IBOutlet var lblTest222: UILabel!
    
    @IBOutlet var lblPerc1: UILabel!
    @IBOutlet var lblPerc2: UILabel!
    @IBOutlet var lblPerc21: UILabel!
    @IBOutlet var lblPerc22: UILabel!
    @IBOutlet var lblPerc211: UILabel!
    @IBOutlet var lblPerc212: UILabel!
    @IBOutlet var lblPerc221: UILabel!
    @IBOutlet var lblPerc222: UILabel!
    
    @IBOutlet var lblStatus1: UILabel!
    @IBOutlet var lblStatus2: UILabel!
    @IBOutlet var lblStatus21: UILabel!
    @IBOutlet var lblStatus22: UILabel!
    @IBOutlet var lblStatus211: UILabel!
    @IBOutlet var lblStatus212: UILabel!
    @IBOutlet var lblStatus221: UILabel!
    @IBOutlet var lblStatus222: UILabel!
    
    @IBOutlet var SVTF1: UIStackView!
    @IBOutlet var SVTS1: UIStackView!
    @IBOutlet var SVTS2: UIStackView!
    @IBOutlet var SVTS21: UIStackView!
    @IBOutlet var SVTS22: UIStackView!
    @IBOutlet var SVST1: UIStackView!
    @IBOutlet var SVST2: UIStackView!
    @IBOutlet var SecondVc: UIView!
    @IBOutlet var SVSTSecond1: UIStackView!
    @IBOutlet var SVTestSecond1: UIStackView!
    @IBOutlet var SVTestSecond2: UIStackView!
    @IBOutlet var SVSTSecond2: UIStackView!
    
    @IBOutlet var SVTestSecond22: UIStackView!
    @IBOutlet var SVTestSecond21: UIStackView!
    @IBOutlet var SVTSsecond: UIStackView!
    
    var arrMain = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let teacherfirst = arrMain.first else {
            return
        }
        teachersFunction(txtNm: lblTeacher1, txtSub: Subject1, obj1: teacherfirst,stack: SVTF1)
        
        if teacherfirst.student.indices.contains(0){
            let studentFirst1 = teacherfirst.student[0]
            
            studentFunction(txtStName: lblStudent1, txtRoll: lblRoll1, obj2: studentFirst1, stack: SVST1)
            
            if studentFirst1.test.indices.contains(0){
                testFunction(txtTest: lblTest1, txtPer: lblPerc1, txtStatus: lblStatus1, obj3: studentFirst1.test[0], stack: SVTS1)
            }
            if studentFirst1.test.indices.contains(1){
                testFunction(txtTest: lblTest2, txtPer: lblPerc2, txtStatus: lblStatus2 , obj3: studentFirst1.test[1], stack: SVTS2)
            }
            
        }
        if teacherfirst.student.indices.contains(1){
            let studentFirst2 = teacherfirst.student[1]
           
            studentFunction(txtStName: lblStudent2, txtRoll: lblRoll2, obj2: studentFirst2, stack: SVST2)
            
            if studentFirst2.test.indices.contains(0){
                testFunction(txtTest: lblTest21, txtPer: lblPerc21, txtStatus: lblStatus21, obj3: studentFirst2.test[0], stack: SVTS21)
          
            }
            if studentFirst2.test.indices.contains(1){
                testFunction(txtTest: lblTest22, txtPer: lblPerc22, txtStatus: lblStatus22, obj3: studentFirst2.test[1], stack: SVTS22)
            }
            
        }
        guard arrMain.indices.contains(1) else {
            return
        }
        let teacherSecond = arrMain[1]
          
        teachersFunction(txtNm: lblTeacher2, txtSub: Subject2, obj1: teacherSecond,stack: SVTSsecond)
        
        if teacherSecond.student.indices.contains(0){
            let studentsecond1 = teacherSecond.student[0]
            
            studentFunction(txtStName: lblStudent21, txtRoll: lblRoll21, obj2: studentsecond1, stack: SVSTSecond1)
            
            if studentsecond1.test.indices.contains(0){
                testFunction(txtTest: lblTest211, txtPer: lblPerc211, txtStatus: lblStatus211, obj3: studentsecond1.test[0], stack: SVTestSecond1)
            }
            if studentsecond1.test.indices.contains(1){
                testFunction(txtTest: lblTest212, txtPer: lblPerc212, txtStatus: lblStatus212 , obj3: studentsecond1.test[1], stack: SVTestSecond2)
            }
            
        }
       if teacherSecond.student.indices.contains(1){
            let studentSecond2 = teacherSecond.student[1]
           
            studentFunction(txtStName: lblStudent22, txtRoll: lblRoll22, obj2: studentSecond2, stack: SVSTSecond2)
            
            if studentSecond2.test.indices.contains(0){
                testFunction(txtTest: lblTest221, txtPer: lblPerc221, txtStatus: lblStatus221, obj3: studentSecond2.test[0], stack: SVTestSecond21)
          
            }
            if studentSecond2.test.indices.contains(1){
                testFunction(txtTest: lblTest222, txtPer: lblPerc222, txtStatus: lblStatus222, obj3: studentSecond2.test[1], stack: SVTestSecond22)
            }
            
        }
        
    }
    
    func teachersFunction(txtNm: UILabel,txtSub: UILabel,obj1: Teacher,stack: UIStackView){
        txtNm.text = obj1.teacher
        txtSub.text = "\(obj1.subject )"
        stack.isHidden = false
    }
    
    func studentFunction(txtStName: UILabel,txtRoll: UILabel, obj2: Students,stack: UIStackView)  {
        txtStName.text = obj2.Studentname
        txtRoll.text = "\(obj2.RollNumber)"
        stack.isHidden = false
    }
    
    func testFunction(txtTest: UILabel,txtPer: UILabel, txtStatus: UILabel, obj3: Test,stack: UIStackView) {
        txtTest.text = obj3.testName
        txtPer.text = "\(obj3.percentage)"
        txtStatus.text = "\(obj3.sta)"
        stack.isHidden = false
    }
}
