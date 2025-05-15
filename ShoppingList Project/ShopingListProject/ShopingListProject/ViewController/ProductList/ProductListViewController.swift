//
//  ProductListViewController.swift
//  ShopingListProject
//
//  Created by mac on 20/06/24.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var viewAdd: UIView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var blinkView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var deleteHeaderView: UIView!
    @IBOutlet var viewSearch: UIView!
    
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var btnDeleteCheckMark: UIButton!
    @IBOutlet var btnShort: UIButton!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnSearch: UIButton!
    
    @IBOutlet var tblList: UITableView!
    
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var lblPurchasePrice: UILabel!
    @IBOutlet var lblTotalPrice: UILabel!
    @IBOutlet var lblSearchbarError: UILabel!
    
  //  @IBOutlet var bottomViewHeightConstraint: NSLayoutConstraint!
   
    @IBOutlet var searchBar: UISearchBar!
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var shoppingListsObject: MainShopingList?
    var purchsePrice: Int = 0
    var filteredArray: [ProductList] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArray = shoppingListsObject?.arrProduct ?? []
        lblHeader.text = shoppingListsObject?.nameSL
        
        //register Cell and Header
        tblList.register(UINib(nibName: "ProductHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProductHeaderCell")
        tblList.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        tblList.tableFooterView = UIView()
        tblList.delegate = self
        tblList.dataSource = self
        searchBar.delegate = self
        
        loadData()
        addButtonViewShadowRadius()

        tableShow()
        startBlinking()
       }
    
   
    override func viewWillAppear(_ animated: Bool) {
        bottomView()
        sortData()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func startBlinking() {
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.blinkView.alpha = 0
                       }, completion: nil)
    }
    
    func showPopup() {
        
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.shoppingListsObject = shoppingListsObject
        popupVC.productDelegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func addButtonViewShadowRadius() {
        
        viewAdd.layer.cornerRadius = viewAdd.frame.size.width/2
        viewAdd.layer.shadowColor = UIColor.black.cgColor
        viewAdd.layer.shadowOpacity = 0.5
        viewAdd.layer.shadowOffset = CGSize(width: -1, height: 2)
        viewAdd.layer.shadowRadius = 3
        viewAdd.layer.masksToBounds = false
    }
    
    func sortData(){

        switch shoppingListsObject?.sortBy {
            case .name:
                switch shoppingListsObject?.sortOrder {
                    case .ascending:
                        filteredArray =  filteredArray.sorted(by: {$0.productName < $1.productName})
                    case .descending:
                        filteredArray = filteredArray.sorted(by: {$0.productName > $1.productName})
                    default:
                        return
                }
            case .store:
                switch shoppingListsObject?.sortOrder {
                    case .ascending:
                        filteredArray =  filteredArray.sorted(by: {$0.store < $1.store})
                    case .descending:
                        filteredArray = filteredArray.sorted(by: {$0.store > $1.store})
                    default:
                        return
                }
            case .quantity:
                switch shoppingListsObject?.sortOrder {
                    case .ascending:
                        filteredArray = filteredArray.sorted(by: {$0.qty < $1.qty})
                    case .descending:
                        filteredArray = filteredArray.sorted(by: {$0.qty > $1.qty})
                    default:
                        return
                }
            case .price:
                switch shoppingListsObject?.sortOrder {
                    case .ascending:
                        filteredArray = filteredArray.sorted(by: {$0.price < $1.price})
                    case .descending:
                        filteredArray = filteredArray.sorted(by: {$0.price > $1.price})
                    default:
                        return
                }
            case .category:
                switch shoppingListsObject?.sortOrder {
                    case .ascending:
                        filteredArray = filteredArray.sorted(by: {$0.store < $1.category})
                    case .descending:
                        filteredArray = filteredArray.sorted(by: {$0.store > $1.category})
                    default:
                        return
                }
            default:
                    return
        }
         tblList.reloadData()
    }
    
    func bottomView() {
        loadData()
       
        let price = shoppingListsObject?.totalProductPrice ?? 0
        
        if price != 0 {
            
            viewBottom.isHidden = false
            lblTotalPrice.text = "\(shoppingListsObject?.totalProductPrice ?? 0).00 $"
            lblPurchasePrice.text = "\(purchsePrice).00"
        }
        else {
            viewBottom.isHidden = true
        }
    }
    
    func tableShow() {
        
        if !filteredArray.isEmpty {
            tblList.isHidden = false
            bgView.isHidden = true
            blinkView.isHidden = true
            btnShort.isHidden = false
            btnDelete.isHidden = false
            btnSearch.isHidden = false
            
        } else {
            tblList.isHidden = true
            bgView.isHidden = false
            blinkView.isHidden = false
            btnShort.isHidden = true
            btnDelete.isHidden = true
            btnSearch.isHidden = true
        }
    }
    
    func loadData() {
    
        if let shoppingList = shoppingListsObject {
            let totalCheckedPrice = shoppingList.checkedTotalPrice
            purchsePrice = totalCheckedPrice
        }
    }
    
    func showEditPopup(object: ProductList?){
        
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "ProductOptionVC") as! ProductOptionVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.productListObj = object
        popupVC.shoppingListsObject = shoppingListsObject
        popupVC.updateProductListDelegate = self
        popupVC.productEditDelegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func cellCheckBox(headerXib: ProductHeaderCell) {
        
        if deleteHeaderView.isHidden == false {
            headerXib.expandView.isHidden = true
           
            if btnDeleteCheckMark.isSelected == true {
                headerXib.btnCheckBox.isSelected = true
                filteredArray[headerXib.section].deleteCheckMark = true
            }
            else {
                headerXib.btnCheckBox.isSelected = false
                filteredArray[headerXib.section].deleteCheckMark = false
            }
        }
        else {
            if filteredArray[headerXib.section].chackMark != true {
                headerXib.btnCheckBox.isSelected = false
             } else {
                headerXib.btnCheckBox.isSelected = true
             }
            
            if filteredArray[headerXib.section].isExpand {
                headerXib.btnExpand.isSelected = true
            
                } else {
                    headerXib.btnExpand.isSelected = false
                  }
             headerXib.expandView.isHidden = false
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
    
    func deleteCheckBox() {
        
        let checkAllSelect = filteredArray.allSatisfy{$0.deleteCheckMark}
        let checkOneSelect = filteredArray.contains { $0.deleteCheckMark }
        
        if checkAllSelect == true {
            btnDeleteCheckMark.isSelected = true
         }
        else{
            if checkOneSelect == true {
                btnDeleteCheckMark.isSelected = false
             }
            else{
                btnDeleteCheckMark.isSelected = false
             }
        }
    }
    
    @objc func expendButton(sender: UIButton) {
        
        let section = sender.tag
        
        filteredArray[section].isExpand = !(filteredArray[section].isExpand)
        
        tblList.reloadSections(IndexSet(integer: section), with: .none)
    }
    
    @objc func headerClick(sender: UIButton) {
        
        if deleteHeaderView.isHidden {
            let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.shoppingListsObject = shoppingListsObject
            popupVC.editMode = true
            popupVC.productObject = filteredArray[sender.tag]
            popupVC.productDelegate = self
            self.present(popupVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func checkBoxTap(sender: UIButton) {
        
        if deleteHeaderView.isHidden == false {
            sender.isSelected.toggle()
            
            if !(filteredArray[sender.tag].deleteCheckMark) {
                filteredArray[sender.tag].deleteCheckMark = true
            }
            else {
                filteredArray[sender.tag].deleteCheckMark = false
            }
            deleteCheckBox()
        } else {
            
            let section = sender.tag
            let checkboxButton = sender
            let arrMainList = UserLocalData.mainShopingList
            
            for List in arrMainList {
                if List.id == shoppingListsObject?.id {
                    
                    if List.arrProduct[section].chackMark == false {
                        shoppingListsObject? = List
                        List.arrProduct[section].chackMark = true
                    filteredArray[section].chackMark = true
                        checkboxButton.isSelected = true
                        
                    } else {
                        shoppingListsObject? = List
                        List.arrProduct[section].chackMark = false
                        filteredArray[section].chackMark = false
                        checkboxButton.isSelected = false
                    }
                    shoppingListsObject?.arrProduct = filteredArray
                }
            }
            UserLocalData.saveArrayToUserDefault(arrData: arrMainList)
            tblList.reloadSections(IndexSet(integer: section), with: .none)
        }
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            // Handle the long press gesture on the cell
            if let cell = gestureRecognizer.view as? UITableViewHeaderFooterView {
                showEditPopup(object: filteredArray[cell.tag])
            }
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func SearchButton(_ sender: UIButton) {
        viewSearch.isHidden = false
    }
    
    @IBAction func searchbarHideAction(_ sender: UIButton) {
        viewSearch.isHidden = true
    }
    
    @IBAction func deleteCheckMarkAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        tblList.reloadData()
    }
    
    
    @IBAction func backToDeleteMode(_ sender: UIButton) {
        let plus = UIImage(systemName: "plus")
       
        headerView.isHidden = false
        deleteHeaderView.isHidden = true
        btnDeleteCheckMark.isSelected = false
        btnAdd.setBackgroundImage(plus, for: .normal)
        tblList.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteIcon(_ sender: UIButton) {
        let trash = UIImage(systemName: "trash.fill")
       
        headerView.isHidden = true
        deleteHeaderView.isHidden = false
        btnAdd.setBackgroundImage(trash, for: .normal)
        tblList.reloadData()
    }
    
    @IBAction func sortAction(_ sender: UIButton) {
        
        let sortVC = storyboard?.instantiateViewController(withIdentifier: "SortProductViewController") as! SortProductViewController
        sortVC.modalPresentationStyle = .overCurrentContext
        sortVC.modalTransitionStyle = .crossDissolve
        sortVC.productObj = shoppingListsObject
        sortVC.sortProductDelegate = self
        present(sortVC, animated: true, completion: nil)
 
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if deleteHeaderView.isHidden == false {
            showAlert {
              //  guard let shoppingListsObject = self.shoppingListsObject else {
                    // Handle the case where shoppingListsObject is nil
                 //   return
               // }
                let plus = UIImage(systemName: "plus")
        
                self.filteredArray = self.filteredArray.filter { !$0.deleteCheckMark }
                self.shoppingListsObject?.arrProduct = self.filteredArray
                
                let sum = self.shoppingListsObject?.arrProduct.reduce(0){ sum, price in sum + price.productTotalPrice}
                self.shoppingListsObject?.totalProductPrice = sum ?? 0
                UserLocalData.updateMainShopingList(with: self.shoppingListsObject! )

                self.bottomView()
                self.tableShow()
                self.deleteHeaderView.isHidden = true
                self.headerView.isHidden = false
                self.deleteCheckBox()
                self.btnAdd.setBackgroundImage(plus, for: .normal)
                self.tblList.reloadData()
               
            }
        }else {
            showPopup()
        }
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ProductListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cellExpanded = filteredArray[section].isExpand
        return cellExpanded ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.SetProductCellData(product: filteredArray[indexPath.section])
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
        
        return cell
    }
    
}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ProductListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProductHeaderCell") as! ProductHeaderCell
        header.lblName.text = filteredArray[section].productName
        header.lblCount.text = "\(filteredArray[section].qty)"
        header.section = section
        header.btnExpand.tag = section
        header.tag = section
        header.btnCheckBox.tag = section
        header.btnHeaderClick.tag = section
       
        header.btnExpand.addTarget(self, action: #selector(expendButton(sender:)), for: .touchUpInside)
        
        header.btnHeaderClick.addTarget(self, action: #selector(headerClick(sender:)), for: .touchUpInside)
        header.btnCheckBox.addTarget(self, action: #selector(checkBoxTap(sender:)), for: .touchUpInside)
       
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ProductListViewController.handleLongPress))
        longPress.cancelsTouchesInView = true
        header.addGestureRecognizer(longPress)
        
        cellCheckBox(headerXib: header)
        bottomView()
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        
        popupVC.shoppingListsObject = shoppingListsObject
        popupVC.editMode = true
        popupVC.productObject = filteredArray[indexPath.section]
        popupVC.productDelegate = self
        
        self.present(popupVC, animated: true, completion: nil)
    }
    
}

extension ProductListViewController: AddViewControllerDelegate {
    func didDismissPresentedViewController(updatedObj: MainShopingList) {
        
        shoppingListsObject = updatedObj
        filteredArray = updatedObj.arrProduct
        
        sortData()
        tableShow()
        bottomView()
    
    }
}

extension ProductListViewController: UpdateProductDelegate {
    func updateProductList(arrUpdatedObj: MainShopingList) {
      
        shoppingListsObject = arrUpdatedObj
        filteredArray = arrUpdatedObj.arrProduct
        bottomView()
        sortData()
        tableShow()
    }
}

extension ProductListViewController: ProductEditModeDelegate {
    
    func eidtModePresentScreen(productListObj: ProductList?) {

        let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.shoppingListsObject = shoppingListsObject
        popupVC.editMode = true
        popupVC.productObject = productListObj
        popupVC.productDelegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
}

// sorting table
extension ProductListViewController: SortProductDelegate {
    
    func updatedSortProduct(updatedObj: MainShopingList) {
       
        if viewSearch.isHidden{
            shoppingListsObject = updatedObj
            filteredArray = updatedObj.arrProduct
            sortData()
        } else {
            shoppingListsObject = updatedObj
            sortData()
        }
    }
}

// Searchbar Delegate
extension ProductListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // If search text is empty, show all data
        if searchText.isEmpty {
            filteredArray = shoppingListsObject?.arrProduct ?? []
            lblSearchbarError.isHidden = true
        } else {
            // Filter the array based on the search text
            filteredArray = shoppingListsObject?.arrProduct.filter { $0.productName.lowercased().contains(searchText.lowercased()) } ?? []
            
            if filteredArray.isEmpty {
                lblSearchbarError.isHidden = false
            }
            else {
                lblSearchbarError.isHidden = true
            }
        }
        sortData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss the keyboard when the search button is clicked
        searchBar.resignFirstResponder()
    }
}
