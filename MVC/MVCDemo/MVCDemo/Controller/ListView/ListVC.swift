//
//  ListVC.swift
//  MVCDemo
//
//  Created by Apple on 01/10/24.
//

import UIKit

class ListVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var tblList: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrObjProduct: [Product] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tblList.register(nib, forCellReuseIdentifier: "ListCell")
        
        tblList.tableFooterView = UIView()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------


    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------

}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrObjProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell",for: indexPath) as! ListCell
        cell.setCellData(obj: arrObjProduct[indexPath.row])
        return cell
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ListVC: UITableViewDelegate {
    
}
