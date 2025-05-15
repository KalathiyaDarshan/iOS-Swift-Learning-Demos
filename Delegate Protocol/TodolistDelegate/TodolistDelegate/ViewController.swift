//
//  ViewController.swift
//  TodolistDelegate
//
//  Created by mac on 29/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var view3: UIView!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lblHours1: UILabel!
    @IBOutlet var lblHourse3: UILabel!
    @IBOutlet var lblHourse2: UILabel!
    @IBOutlet var hourseView3: UIView!
    @IBOutlet var hourseView2: UIView!
    @IBOutlet var hourseView1: UIView!
    
    var arrOfTodo = [todoData]()
    var color1 = [UIColor]()
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadios(view: hourseView1)
        cornerRadios(view: hourseView2)
        cornerRadios(view: hourseView3)
        
    }
    
    @IBAction func nextview(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        nextVC.txtDelegate = self
        navigationController?.pushViewController(nextVC, animated: true)
        //    present(nextVC, animated: true, completion: nil)
    }
    
    func viewBorder(view: UIView, brColor: UIColor)  {
        
        view.layer.borderWidth = 2
        view.layer.borderColor = brColor.cgColor
        
    }
    func cornerRadios(view: UIView){
        
        view.layer.cornerRadius = view.frame.width/2
    }
    
}
extension ViewController: sendData{
    func details(getTaskData: todoData) {

        arrOfTodo.append(getTaskData)
         let pr = arrOfTodo.last?.priority
     
        switch pr {
            case .green:
                color1.append(.green)
            case .red :
                color1.append(.red)
            case .yellow :
                color1.append(.yellow)
           
            case .none:
                return
        }
        
        if arrOfTodo.indices.contains(0) == true {
            view1.isHidden = false
            lbl1.text = arrOfTodo[0].task
            lblHours1.text = "\(arrOfTodo[0].hours)"
            viewBorder(view: view1, brColor: color1[0])
           // print(color1)
        }
        
        if arrOfTodo.indices.contains(1) == true {
            view2.isHidden = false
            lbl2.text = arrOfTodo[1].task
            lblHourse2.text = "\(arrOfTodo[1].hours)"
            viewBorder(view: view2, brColor: color1[1])
        }
        
        if arrOfTodo.indices.contains(2) == true {
            view3.isHidden = false
            lbl3.text = arrOfTodo[2].task
            lblHourse3.text = "\(arrOfTodo[2].hours)"
            viewBorder(view: view3, brColor: color1[2])
        }
    }
    
}
