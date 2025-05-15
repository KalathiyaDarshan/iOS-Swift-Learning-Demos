//
//  ProiflesVC.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 28/03/25.
//

import UIKit

class ProfilesVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblProfiles: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var obj1: Contact?
    var arrProfileDetail: [ContactProfile] = []
    let sharedManager = ContactManager.shared

    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        sharedManager.delegate = self
        sharedManager.fetchContactProfile()
        self.tblProfiles.register(UINib(nibName: "ProfileDetailCell", bundle: nil), forCellReuseIdentifier: "ProfileDetailCell")
    }
    
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnBackClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }


    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ProfilesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProfileDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailCell") as! ProfileDetailCell
        let profileDetail = arrProfileDetail[indexPath.row]
        cell.configCell(objContactProfile: profileDetail)
        return cell
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ProfilesVC: UITableViewDelegate {
    
}

// ----------------------------------------------------------
//                       MARK: - ContactManager Delegate -
// ----------------------------------------------------------
extension ProfilesVC: ContactManagerDelegate {    
    func didRetrieveContactProfileData(_ arrData: [Any]) {
        print("arrProfileCount: ", arrData.count)
        if let profile = arrData as? [ContactProfile] {
            arrProfileDetail = profile
            tblProfiles.reloadData()
        } else {
            print("Error: arrData does not contain Contact objects")
        }
    }
}
