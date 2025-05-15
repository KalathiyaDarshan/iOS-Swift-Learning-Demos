//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//

import UIKit

class ViewListVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblList: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let coreData = CoreDataManager.shared
    var arrStudentData: [StudentDetails] = []
    
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
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func fetchData(){
        self.coreData.fetchData { studentModelArray in
            self.arrStudentData = studentModelArray
        }
        tblList.reloadData()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    
    // ----------------------------------------------------------
    //                       MARK: - Action -
    // ----------------------------------------------------------
    @objc func deleteAction(sender: UIButton) {
        coreData.deleteData(by: arrStudentData[sender.tag].id) { success in
            if success {
                self.fetchData()
            } else {
                print("Failed to delete student")
            }
        }
    }
    
    @objc func editAction(sender: UIButton) {
        
        let editVc = storyboard?.instantiateViewController(identifier: "EditVC") as! EditVC
        editVc.objStudent = arrStudentData[sender.tag]
        editVc.updateDelegate = self
        navigationController?.pushViewController(editVc, animated: true)
    }

}

// ----------------------------------------------------------------
//       MARK: - UITableView DataSource & UITableViewDataSource-
// ----------------------------------------------------------------
extension ViewListVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        cell.setData(obj: arrStudentData[indexPath.row])
        
        
         cell.btnDelete.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
        
        return cell
    }
}

extension ViewListVC: updateDetailsDelegate {
    func update() {
        fetchData()
    }
}
