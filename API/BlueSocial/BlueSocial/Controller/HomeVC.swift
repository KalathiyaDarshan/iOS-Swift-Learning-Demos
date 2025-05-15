//
//  HomeVC.swift
//  BlueSocial
//
//  Created by mac on 29/07/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var lblId: UILabel!
    var userId = UserLocalData.saveUserId
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblId.text = "Home Screen Login/Register Success with User ID(\(userId))"
       
    }

}
