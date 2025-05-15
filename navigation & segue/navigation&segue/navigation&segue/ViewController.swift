//
//  ViewController.swift
//  navigation&segue
//
//  Created by mac on 16/05/24.
//
// push and pop
// present and dismiss  =  dissapear method not call
import UIKit

class ViewController: UIViewController,send {
    var name: String = " "
    
    func senddata(detail: String) {
        name = detail
    }
    
    
    @IBOutlet var txtDetail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func BttonsequeActiom(_ sender: UIButton) {
        performSegue(withIdentifier: "sequeIdetifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sequeIdetifier"{
            if let seg = segue.destination as? SecondViewController{
                seg.name = txtDetail.text ?? ""
            }
        }
        
        if segue.identifier == "sequeIdetifier1"{
            if let seg = segue.destination as? SecondViewController{
                seg.name = txtDetail.text ?? ""
            }
        }
    }
    
    @IBAction func SecondAction(_ sender: UIButton) {
        let nextVc = storyboard?.instantiateViewController(withIdentifier: "Secondpage") as! SecondViewController 
        
        nextVc.datadelegate = self
        nextVc.name = txtDetail.text ?? ""
        navigationController?.pushViewController(nextVc, animated: true)
        //  present(nextVc, animated: true,completion: nav)
    }
    /*
     override func viewWillDisappear(_ animated: Bool) {
     print("Firs",#function)
     }
     override func viewDidDisappear(_ animated: Bool) {
     print("Firs",#function)
        
     }
    */
     override func viewWillAppear(_ animated: Bool) {
     print("Firs",#function)
     }
     override func viewDidAppear(_ animated: Bool) {
     print("Firs",#function)
        print("second page data: ",name)
     }
     
}
func nav()
{
    print("Presentation animation completed")
}

