//
//  ViewController.swift
//  BeaconIntegrationDemo
//
//  Created by Darshan Kalathiya on 13/12/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var lblRSSI: UILabel!
    @IBOutlet weak var lblUUID: UILabel!
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblMinor: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var tblBeaconRecord: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var objBeaconManager = BeaconManager.shared
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func updateBeaconInfo(beacon: BeaconRecord) {
        self.lblRSSI.text = "\(beacon.averageRSSI)"
        self.lblUUID.text = "UUID: \(beacon.uuid)"
        self.lblMinor.text = "Minor: \(beacon.minor)"
        self.lblMajor.text = "Major: \(beacon.major)"
        self.lblDistance.text = "Distance: \(beacon.distance) Mtr"
    }
    
    func setupUI() {
        let nib = UINib(nibName: "BeaconRecordCell", bundle: nil)
        tblBeaconRecord.register(nib, forCellReuseIdentifier: "BeaconRecordCell")
        
        objBeaconManager.beaconScanner(with: UUID(uuidString: "5C9B361E-A83F-11ED-AFA1-0242AC120002")!)
        
        reloadTbl()
        updateOneCell()
        updateNearestBeacon()
    }
    
    func reloadTbl(){
        objBeaconManager.updateArray = {
            self.tblBeaconRecord.reloadData()
        }
    }
    
    func updateOneCell(){
        objBeaconManager.oneBeaconObjUpdate = { index, objBeaconRecord in
            // Reload only the cell at the corresponding index
            let indexPath = IndexPath(row: index, section: 0)

            if let cell = self.tblBeaconRecord.cellForRow(at: indexPath) as? BeaconRecordCell {
                cell.lblRSSI.text = "\(objBeaconRecord.averageRSSI)"
                cell.lblDistance.text = "Distance: \(objBeaconRecord.distance) Mtr"
            }
        }
    }
    
    func updateNearestBeacon() {

        objBeaconManager.nearestBeacon = { objBeaconRecord in
            self.updateBeaconInfo(beacon: objBeaconRecord)
        }
    }
    
    
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objBeaconManager.arrBeaconsRecordObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconRecordCell", for: indexPath) as! BeaconRecordCell
        cell.setData(obj: objBeaconManager.arrBeaconsRecordObj[indexPath.row])
        return cell
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ViewController: UITableViewDelegate {
    
}
