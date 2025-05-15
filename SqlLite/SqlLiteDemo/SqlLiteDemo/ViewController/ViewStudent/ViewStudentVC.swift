//
//  ViewStudentVC.swift
//  SqlLiteDemo
//
//  Created by mac on 05/09/24.
//

import UIKit

class ViewStudentVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblList: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrStudentList: [StudentModel] = []
    var sqlManager =  SqlLiteManager.shared
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tableCellNib = UINib(nibName: "ListCell", bundle: nil)
        tblList.register(tableCellNib, forCellReuseIdentifier: "ListCell")
        tblList.tableFooterView = UIView()
        fetchData()
        
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Action -
    // ----------------------------------------------------------
    @objc func deleteAction(sender: UIButton) {
        sqlManager.deleteRecord(by: arrStudentList[sender.tag].id)
        fetchData()
    }
    
    @objc func editAction(sender: UIButton) {
        let updateVC = storyboard?.instantiateViewController(identifier: "UpdateVC") as! UpdateVC
        updateVC.objStudent = arrStudentList[sender.tag]
        updateVC.updateDelegate = self
        navigationController?.pushViewController(updateVC, animated: true)
    }
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func fetchData(){
       
        arrStudentList = sqlManager.fetchAllRecord()
        tblList.reloadData()
    }
}

// ---------------------------------------------------------------------
//             MARK: - UITableView DataSource, UITableView Delegate -
// ---------------------------------------------------------------------
extension ViewStudentVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        
        cell.btnDelete.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
        cell.setData(obj: arrStudentList[indexPath.row])
        return cell
    }
}


extension ViewStudentVC: updateDetailsDelegate {
    func update() {
        fetchData()
    }
}
