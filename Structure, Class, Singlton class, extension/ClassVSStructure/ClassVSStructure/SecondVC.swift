//
//  SecondVC.swift
//  ClassVSStructure
//
//  Created by mac on 31/07/24.
//

import UIKit

class SecondVC: UIViewController {
    
    var objBackScreenClass: UserClass?
    var objBackScreenStructure: UserStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("SecondVC -class-Name:",objBackScreenClass?.name ?? "")
        print("SecondVC-Structure-Name",objBackScreenStructure?.name ?? "")
    }
    

   
}
