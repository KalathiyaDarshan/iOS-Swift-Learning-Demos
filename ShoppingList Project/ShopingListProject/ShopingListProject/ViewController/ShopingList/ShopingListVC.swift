//
//  ViewController.swift
//  ShopingListProject
//
//  Created by mac on 18/06/24.
//

import UIKit

class ShopingListVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var viewAdd: UIView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var blinkView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var viewTable: UIView!
    @IBOutlet var deleteView: UIView!
 
    @IBOutlet var tblList: UITableView!
    
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var btndeleteAction: UIButton!
    @IBOutlet var btnDeleteViewCheckBox: UIButton!
    @IBOutlet var btnDeleteIcon: UIButton!
    @IBOutlet var btnShortingIcon: UIButton!
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrShoppingList = UserLocalData.mainShopingList
    var shoppingListsObject: MainShopingList?
    var selectedOrder = UserLocalData.sortingOrder
    var selectedCriteria = UserLocalData.sortingCriteria
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAdd.layer.cornerRadius = viewAdd.frame.size.width/2
        viewAdd.layer.shadowColor = UIColor.black.cgColor
        viewAdd.layer.shadowOpacity = 0.5
        viewAdd.layer.shadowOffset = CGSize(width: -1, height: 2)
        viewAdd.layer.shadowRadius = 3
        viewAdd.layer.masksToBounds = false
        
        tblList.register(UINib(nibName: "ListTblCell", bundle: nil), forCellReuseIdentifier: "ListTblCell")
        tblList.tableFooterView = UIView()
        
        viewShow()
        startBlinking()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    private func loadData() {
        arrShoppingList = UserLocalData.mainShopingList
        selectedOrder = UserLocalData.sortingOrder
        selectedCriteria = UserLocalData.sortingCriteria
        sortData()
    }
    
    
    func sortData() {
        
        if selectedOrder == nil{
            UserLocalData.sortingOrder = .ascending
        }
        
        if selectedCriteria == nil {
            UserLocalData.sortingCriteria = .name
        }
       
        switch selectedCriteria {
            case .name:
                switch selectedOrder {
                    case .ascending:
                        arrShoppingList =  arrShoppingList.sorted(by: {$0.nameSL < $1.nameSL})
                    case .descending:
                        arrShoppingList =  arrShoppingList.sorted(by: {$0.nameSL > $1.nameSL})
                    default:
                        return
                }
            case .priority:
                switch selectedOrder {
                    case .ascending:
                        arrShoppingList =  arrShoppingList.sorted(by: {$0.priority.rawValue < $1.priority.rawValue
                        })
                    case .descending:
                        arrShoppingList =  arrShoppingList.sorted(by: {$0.priority.rawValue > $1.priority.rawValue})
                    default:
                        return
                }
            default:
                return
        }
        UserLocalData.saveArrayToUserDefault(arrData: arrShoppingList)
        tblList.reloadData()
    }
    
    func startBlinking() {
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.blinkView.alpha = 0
                       }, completion: nil)
    }
    
    func viewShow() {
        
        if arrShoppingList.isEmpty {
            tblList.isHidden = true
            bgView.isHidden = false
            blinkView.isHidden = false
            btnDeleteIcon.isHidden = true
            btnShortingIcon.isHidden = true
            
        }else {
            tblList.isHidden = false
            bgView.isHidden = true
            blinkView.isHidden = true
            btnDeleteIcon.isHidden = false
            btnShortingIcon.isHidden = false
        }
    }
    
    func showAddProductPopup() {
        
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddShopingListVC") as! AddShopingListVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.delegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func showEditPopup(object: MainShopingList){
        
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "ShopingListOptionVC") as! ShopingListOptionVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.shoppingListsObject = object
        popupVC.popupDelegate = self
        popupVC.editDelegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func cellCheckBox(cell: ListTblCell) {
        
        if deleteView.isHidden == false {
           
            cell.btnDownAction.isHidden = true
            cell.btnCeckBox.isHidden = false
            btnAdd.isHidden = true
            btndeleteAction.isHidden = false
            
            if btnDeleteViewCheckBox.isSelected == true {
                cell.btnCeckBox.isSelected = true
                arrShoppingList[cell.tag].deleteCheckMark = true
            }else {
                cell.btnCeckBox.isSelected = false
                arrShoppingList[cell.tag].deleteCheckMark = false
            }
        }
        else {
            cell.btnDownAction.isHidden = false
            cell.btnCeckBox.isHidden = true
            btnAdd.isHidden = false
            btndeleteAction.isHidden = true
            btnDeleteViewCheckBox.isSelected = false
        }
    }
    
    func deleteViewCheckBox() {
        
        let emptySquareImage = UIImage(systemName: "square")
        let minusSquareImage = UIImage(systemName: "minus.square")
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let minus = minusSquareImage?.withConfiguration(configuration)
        let empty = emptySquareImage?.withConfiguration(configuration)
        
        let checkAllSelect = arrShoppingList.allSatisfy { $0.deleteCheckMark }
        let checkOneSelect = arrShoppingList.contains { $0.deleteCheckMark }
        
        if checkAllSelect == true {
            btnDeleteViewCheckBox.isSelected = true
         }
        else{
            if checkOneSelect == true {
                btnDeleteViewCheckBox.isSelected = false
                btnDeleteViewCheckBox.setImage(minus, for: .normal)
            }
            else{
                btnDeleteViewCheckBox.isSelected = false
                btnDeleteViewCheckBox.setImage(empty, for: .normal)
            }
        }
    }
    
    func showAlert(completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            // Handle the deletion here
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if !headerView.isHidden {
            if gestureRecognizer.state == .began {
                // Handle the long press gesture on the cell
                if let cell = gestureRecognizer.view as? UITableViewCell {
                    // Perform actions specific to the cell
                    showEditPopup(object: arrShoppingList[cell.tag])
                }
            }
        }
    }
    
    @objc func cellCheckBoxClick(sender: UIButton) {
        
        sender.isSelected.toggle()
            
            if !arrShoppingList[sender.tag].deleteCheckMark {
                arrShoppingList[sender.tag].deleteCheckMark = true
                sender.isSelected = true
              } else {
                 arrShoppingList[sender.tag].deleteCheckMark = false
                sender.isSelected = false
              }
        deleteViewCheckBox()
    }
    
    @objc func downButtonTap(sender: UIButton) {
        
        let row = sender.tag
        arrShoppingList[row].isExpand = !(arrShoppingList[row].isExpand)
        let indexPath = IndexPath(row: row, section: 0)
        tblList.reloadRows(at: [indexPath], with: .none)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func deleteCheckboxAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        tblList.reloadData()
    }
    
    @IBAction func multipleDeleteAction(_ sender: UIButton) {
     
        showAlert {
            self.arrShoppingList = self.arrShoppingList.filter { !$0.deleteCheckMark }
            
            UserLocalData.mainShopingList = self.arrShoppingList
            self.deleteView.isHidden = true
            self.headerView.isHidden = false
            self.btnDeleteViewCheckBox.isSelected = false
            self.btndeleteAction.isHidden = true
            self.btnAdd.isHidden = false
            self.deleteViewCheckBox()
            self.startBlinking()
            self.viewShow()
            self.tblList.reloadData()
        }
    }
    
    @IBAction func deleteBackAction(_ sender: UIButton) {
        let emptySquareImage = UIImage(systemName: "square")
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let empty = emptySquareImage?.withConfiguration(configuration)
        
        headerView.isHidden = false
        deleteView.isHidden = true
        btnDeleteViewCheckBox.isSelected = false
        btnDeleteViewCheckBox.setImage(empty, for: .normal)
        tblList.reloadData()
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        
        headerView.isHidden = true
        deleteView.isHidden = false
        tblList.reloadData()
    }
    
    @IBAction func btnShortAction(_ sender: UIButton) {
        
        let sortVC = storyboard?.instantiateViewController(withIdentifier: "SortShopingListVC") as! SortShopingListVC
        sortVC.modalPresentationStyle = .overCurrentContext
        sortVC.modalTransitionStyle = .crossDissolve
       // sortVC.updatedSortDelegate = self
        sortVC.updatedSortDelegate = self
        present(sortVC, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        showAddProductPopup()
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ShopingListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrShoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTblCell", for: indexPath) as! ListTblCell
        cell.indexPath = indexPath
        cell.tableView = tblList
        cell.tag = indexPath.row
        cell.btnDownAction.tag = indexPath.row
        cell.btnCeckBox.tag = indexPath.row
        
        cell.btnCeckBox.addTarget(self, action: #selector(cellCheckBoxClick(sender:)), for: .touchUpInside)
        
        cell.btnDownAction.addTarget(self, action: #selector(downButtonTap(sender:)), for: .touchUpInside)
        
        cell.setCellData(object: arrShoppingList[indexPath.row])
      
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ShopingListVC.handleLongPress))
            longPress.cancelsTouchesInView = true
            cell.addGestureRecognizer(longPress)
         
        if arrShoppingList[indexPath.row].isExpand != true {
            cell.viewSecondMain.isHidden = false
            cell.btnDownAction.isSelected = true
        } else {
            cell.viewSecondMain.isHidden = true
            cell.btnDownAction.isSelected = false
        }
        cellCheckBox(cell: cell)
        
        return cell
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ShopingListVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !headerView.isHidden {
            let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
            productVC.shoppingListsObject = UserLocalData.mainShopingList[indexPath.row]
            navigationController?.pushViewController(productVC, animated: true)
        }
    }
}

// back to Add Category Screen and Navigate Product Screen
extension ShopingListVC: AddVCDelegate {
    func didDismissPresentedViewController(updatedObj: MainShopingList?,screen: WhichScreen) {
        
        shoppingListsObject = updatedObj
        loadData()
       // tblList.reloadData()
        
        switch screen{
            
            case .AddScreeen:
                let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                productVC.shoppingListsObject = updatedObj
                navigationController?.pushViewController(productVC, animated: true)
                
            case .EditScreen:
                break
        }
        viewShow()
    }
}

// back to Add Category Screen and show arrShopingList Empty or not
extension ShopingListVC: EditPopupVCDelegate {
    func didDismissPresentedViewController(arrUpdatedObj: [MainShopingList]) {
        
        arrShoppingList = arrUpdatedObj
        
        if arrShoppingList.count == 0 {
            viewShow()
        }
    }
}

// When back to the edit popup and Present Edit Screen
extension ShopingListVC: EditeModeDelegate {
    func eidtModePresentScreen(mainShopingObj: MainShopingList?) {
        
        loadData()
        tblList.reloadData()
        
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddShopingListVC") as! AddShopingListVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.shoppingListsObject = mainShopingObj
        popupVC.editScreen = true
        popupVC.delegate = self
        self.present(popupVC, animated: false, completion: nil)
    }
}

// Back to Sort Popup
extension ShopingListVC: UpdateSortDelegate {
    func updatedSorting(updateOrder: SortingOrder?, updatedCategory: SortingCriteria?) {
      
        selectedCriteria = updatedCategory
        selectedOrder = updateOrder
       // loadData()
        sortData()
    }
}
