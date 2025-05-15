//
//  ViewController.swift
//  MapDemo
//
//  Created by Darshan Kalathiya on 27/01/25.
//

import UIKit

class MapListVC: UIViewController {

    @IBOutlet weak var tblMapsList: UITableView!
    
    var arrMapType = MapType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
    }
    
    func setupUI() {
        let nib = UINib(nibName: "MapCell", bundle: nil)
        tblMapsList.register(nib, forCellReuseIdentifier: "MapCell")
        
        let headernib = UINib(nibName: "MapHeader", bundle: nil)
        tblMapsList.register(headernib, forHeaderFooterViewReuseIdentifier: "MapHeader")
               
    }
}


extension MapListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMapType.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as! MapCell
        cell.configure(with: arrMapType[indexPath.section])
        
        cell.buttonTappedCallback = { mapName in
            let mapVC = self.storyboard?.instantiateViewController(identifier: "MapVC") as! MapVC
            mapVC.mapType = mapName
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MapHeader") as! MapHeader
        header.configure(with: arrMapType[section])
        return header
    }
}

extension MapListVC: UITableViewDelegate {
    
}
