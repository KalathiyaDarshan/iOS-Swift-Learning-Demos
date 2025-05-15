
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
    
    var objmain = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        for(indTeacher,objTeacher) in objmain.enumerated()
        {
            if indTeacher == 0{
                Teachers(txtNm: lblTeacher1, txtSub: Subject1, obj1: objTeacher)
           
                for (indexstud,lblStud) in objTeacher.student.enumerated(){
                    if indexstud == 0{
                        SVST1.isHidden = false
                       Student(txtStName: lblStudent1, txtRoll: lblRoll1, obj2: lblStud)
                        
                        for (testIndex,lblTest) in lblStud.test.enumerated(){
                            if testIndex == 0{
                                SVTS1.isHidden = false
                                Test(txtTest: lblTest1, txtPer: lblPerc1, txtStatus: lblStatus1, obj3: lblTest)
                            }
                            if testIndex == 1{
                                SVTS2.isHidden = false
                                Test(txtTest: lblTest2, txtPer: lblPerc2, txtStatus: lblStatus2, obj3: lblTest)
                            }
                        }
                        
                    }
                    if indexstud == 1{
                        SVST2.isHidden = false
                        Student(txtStName: lblStudent2, txtRoll: lblRoll2, obj2: lblStud)
                        
                        for (testIndex1,lblTest1) in lblStud.test.enumerated(){
                            if testIndex1 == 0{
                                SVTS21.isHidden = false
                                Test(txtTest: lblTest21, txtPer: lblPerc21, txtStatus: lblStatus21, obj3: lblTest1)
                            }
                            if testIndex1 == 1{
                                SVTS22.isHidden = false
                                Test(txtTest: lblTest22, txtPer: lblPerc22, txtStatus: lblStatus22, obj3: lblTest1)
                            }
                        }
                    }
                }
                
            }
            if indTeacher == 1{
                SVTSsecond.isHidden = false
                Teachers(txtNm: lblTeacher2, txtSub: Subject2, obj1: objTeacher)
                
                for (indexStud1,lblstud1) in objTeacher.student.enumerated(){
                    if indexStud1 == 0 {
                        SVSTSecond1.isHidden = false
                        Student(txtStName: lblStudent21, txtRoll: lblRoll21, obj2: lblstud1)
                        
                        for (testIndex21,lblTest21) in lblstud1.test.enumerated(){
                            if testIndex21 == 0{
                                SVTestSecond1.isHidden = false
                                Test(txtTest: lblTest211, txtPer: lblPerc211, txtStatus: lblStatus211, obj3: lblTest21)
                            }
                            if testIndex21 == 1{
                                SVTestSecond2.isHidden = false
                                Test(txtTest: lblTest222, txtPer: lblPerc222, txtStatus: lblStatus222, obj3: lblTest21)
                            }
                        }
                        
                    }
                    if indexStud1 == 1 {
                        SVSTSecond2.isHidden = false
                        Student(txtStName: lblStudent22, txtRoll: lblRoll22, obj2: lblstud1)
                       
                        for (testIndex211,lblTest211) in lblstud1.test.enumerated(){
                            if testIndex211 == 0{
                              SVTestSecond21.isHidden = false
                                Test(txtTest: lblTest221, txtPer: lblPerc222, txtStatus: lblStatus222, obj3: lblTest211)
                            }
                            if testIndex211 == 1{
                                SVTestSecond22.isHidden = false
                                Test(txtTest: lblTest222, txtPer: lblPerc222, txtStatus: lblStatus222, obj3: lblTest211)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func Teachers(txtNm: UILabel,txtSub: UILabel,obj1: Teacher){
         txtNm.text = obj1.teacher
         txtSub.text = "\(obj1.subject )"
    }
    
    func Student(txtStName: UILabel,txtRoll: UILabel, obj2: Students)  {
        txtStName.text = obj2.Studentname
        txtRoll.text = "\(obj2.RollNumber)"
    }
    
    func Test(txtTest: UILabel,txtPer: UILabel, txtStatus: UILabel, obj3: Test) {
        txtTest.text = obj3.testName
        txtPer.text = "\(obj3.percentage)"
        txtStatus.text = "\(obj3.sta)"
    }
}
