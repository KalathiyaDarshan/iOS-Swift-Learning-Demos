//
//  ViewController.swift
//  ExpandableTableview
//
//  Created by mac on 13/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tblExpandable: UITableView!
    
    var arrObjMain = [tableSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableCellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tblExpandable.register(tableCellNib, forCellReuseIdentifier: "TableViewCell")
        
        getClassData()
    }
    
    func getClassData() {
        
        let objtblrw1 = tableRow.init(rowData: "1")
        let objtblrw2 = tableRow.init(rowData: "2")
        let objtblrw3 = tableRow.init(rowData: "3")
        
        let arrobj1 = [objtblrw1,objtblrw2,objtblrw3]
        
        let objSection1 = tableSection.init(sectionData: "One", expandValue: false, arrRow: arrobj1)
        
        let objtblrw4 = tableRow(rowData: "4")
        let objtblrw5 = tableRow(rowData: "5")
        let arrobj2 = [objtblrw4, objtblrw5]
        
        let objSection2 = tableSection(sectionData: "Two", expandValue: false, arrRow: arrobj2)
        
        let objtblrw6 = tableRow(rowData: "6")
        let objtblrw7 = tableRow(rowData: "7")
        let arrobj3 = [objtblrw6, objtblrw7]
        let objSection3 = tableSection(sectionData: "Three", expandValue: false, arrRow: arrobj3)
        
        arrObjMain = [objSection1, objSection2, objSection3]
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(arrObjMain[section].expandValue)
        return arrObjMain[section].expandValue ? arrObjMain[section].arrRow.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.lblData.text = arrObjMain[indexPath.section].arrRow[indexPath.row].rowData // arrRow[indexPath.section][indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrObjMain.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrObjMain[section].sectionData
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        let label = UILabel()
        label.text = arrObjMain[section].sectionData
        label.frame = CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 28)
        headerView.addSubview(label)
        
        headerView.tag = section
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeader(_:)))
        headerView.addGestureRecognizer(tapGesture)
        
        return headerView
    }
    
    
    @objc func didTapHeader(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        arrObjMain[section].expandValue.toggle()
        tblExpandable.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
}
