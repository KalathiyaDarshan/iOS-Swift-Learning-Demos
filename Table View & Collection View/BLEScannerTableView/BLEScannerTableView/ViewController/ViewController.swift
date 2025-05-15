//
//  ViewController.swift
//  BLEScannerTableView
//
//  Created by Darshan Kalathiya on 14/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblUUID: UITableView!
    @IBOutlet weak var lblFilterCount: UILabel!
    @IBOutlet weak var btnHader: UIButton!
    @IBOutlet weak var imgArrow: UIImageView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrFilterUUID = [FilterUUID]() {
        didSet {
            arrFilterUUID.map { $0.uuid }.forEach { print($0) }
            self.tblUUID.reloadData()
            self.setHeader()
            self.adjustTableHeight()
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setHeader()
        self.tblUUID.register(UINib(nibName: "UUIDCell", bundle: nil), forCellReuseIdentifier: "UUIDCell")
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.adjustTableHeight()
        }
    }

    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnHaderClick(_ sender: UIButton) {
        tblUUID.isHidden.toggle()
        imgArrow.image = UIImage(systemName: tblUUID.isHidden ? "chevron.down" : "chevron.up")
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func calculateTableViewHeight() -> CGFloat {
        tblUUID.layoutIfNeeded() // Ensure the layout is up-to-date
        return tblUUID.contentSize.height
    }
    
    func adjustTableHeight() {
        let tableViewHeight = calculateTableViewHeight()
        
        // Set a maximum height for the bottom sheet (optional)
        let maxHeight: CGFloat = 210.00
        let newHeight = min(tableViewHeight, maxHeight)
        
        // Update the height constraint
        tblHeight.constant = newHeight
        
        // If table view content is larger than the max height, enable scrolling
        tblUUID.isScrollEnabled = tableViewHeight > maxHeight

        self.view.layoutIfNeeded()
    }
    
    func setHeader() {
        lblFilterCount.text = arrFilterUUID.isEmpty ? "No Filter" : "\(arrFilterUUID.count) Filter"
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilterUUID.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UUIDCell", for: indexPath) as! UUIDCell
        
        if indexPath.row == arrFilterUUID.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                cell.txtUUID.becomeFirstResponder()
            }
            cell.setData(objFilterUUID: FilterUUID(uuid: ""))
            
        } else {
            // Handle normal rows
            let filterUUID = arrFilterUUID[indexPath.row]
            cell.setData(objFilterUUID: filterUUID)
        }
                
        cell.btnSaveTapped = { [weak self] isInsertMode,objFilterUUID in
            guard let self = self else { return }
            
            if isInsertMode {
                if let obj = objFilterUUID {
                    self.arrFilterUUID.append(obj)
                }
                
            }else {
                self.tblUUID.reloadRows(at: [indexPath], with: .none)
            }
                
            self.scrollToLastRow(of: self.tblUUID)
        }
                
        cell.toastMassage = { message in
           // view.makeToast(message)
            print(message)
        }
        
        return cell
    }
        
    private func scrollToLastRow(of tableView: UITableView, delay: TimeInterval = 0.2) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let lastSection = tableView.numberOfSections - 1
            if lastSection >= 0 {
                let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
                if lastRow >= 0 {
                    let indexPath = IndexPath(row: lastRow, section: lastSection)
                    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    
                    if let cell = self.tblUUID.cellForRow(at: indexPath) as? UUIDCell {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            cell.txtUUID.becomeFirstResponder()
                        }
                    }
                }
            }
        }
    }

}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == arrFilterUUID.count {
            return nil
        } else {
            
            // Edit Action
            let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
                
                for i in 0..<self.arrFilterUUID.count {
                    if i == indexPath.row {
                        self.arrFilterUUID[i].isSaved = false
                        self.arrFilterUUID[i].isEditMode = true
                    } else {
                        self.arrFilterUUID[i].isSaved = true
                        self.arrFilterUUID[i].isEditMode = false
                    }
                }
                
                self.tblUUID.reloadData()
                
                if let cell = self.tblUUID.cellForRow(at: indexPath) as? UUIDCell {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        cell.txtUUID.becomeFirstResponder()
                    }
                }
                
                print("Edit tapped for \(self.arrFilterUUID[indexPath.row])")
                completionHandler(true)
            }
            
            // Delete Action
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                // Perform delete action
                self.arrFilterUUID.remove(at: indexPath.row)
                completionHandler(true)
            }
            
            // Create swipe actions configuration with both actions
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
            return configuration
        }
    }
}

class FilterUUID {
    var uuid: String
    var isSaved: Bool
    var isEditMode: Bool
    
    init(uuid: String, isSaved: Bool = false, isEditMode: Bool = false) {
        self.uuid = uuid
        self.isSaved = isSaved
        self.isEditMode = isEditMode
    }
}
