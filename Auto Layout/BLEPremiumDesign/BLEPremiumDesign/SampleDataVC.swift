//
//  SampleDataVC.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 27/12/24.
//

import UIKit

class SampleDataVC: UIViewController {

    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var tblSampleData: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrSampleData = [SampleData]()
    var isExpand : Bool = false
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func setupUI(){
        self.tblSampleData.register(UINib(nibName: "SampleDataHeaderCell", bundle: nil),forCellReuseIdentifier: SampleDataHeaderCell.identifier)
        self.tblSampleData.register(UINib(nibName: "SampleDataCell", bundle: nil),forCellReuseIdentifier: SampleDataCell.identifier)

        setData()
    }
    
    func setData() {
        let objcustomBLE = SampleDataRecord(
            deviceName: "Ble Device",
            deviceLogicalName: "N/A",
            deviceMacAddress: "3E:95:06:C0:A1:17",
            deviceRssi: -52,
            deviceType: "customBLE",
            avgDistance: 0.0,
            advertiseInterval: 0,
            isConnectable: false,
            txPower: -58,
            scanRecord: "1EFF06000109200208F9015C08B4884E465453D2B32A67431B1B1E6E03593B",
            timeStamp: 1720612659171
        )
            
        let objiBeacon = SampleDataRecord(
            deviceName: "Ble Device",
            deviceLogicalName: "N/A",
            deviceMacAddress: "3E:95:06:C0:A1:17",
            deviceRssi: -52,
            deviceType: "iBeacon",
            avgDistance: 0.0,
            advertiseInterval: 0,
            isConnectable: false,
            txPower: -58,
            uuid: "2f234454-cf6d-4a0f-adf2-f4911ba9ffa6",
            major: 0,
            minor: 100,
            scanRecord: "1EFF06000109200208F9015C08B4884E465453D2B32A67431B1B1E6E03593B",
            timeStamp: 1720612659171
        )
        
        let objEddystone = SampleDataRecord(
            deviceName: "Ble Device",
            deviceLogicalName: "N/A",
            deviceMacAddress: "3E:95:06:C0:A1:17",
            deviceRssi: -52,
            deviceType: "EddystoneUID",
            avgDistance: 0.0,
            advertiseInterval: 0,
            isConnectable: false,
            txPower: -58,
            nameSpace: "adf491110ba987ffa6cc",
            instanceld: "3ABE7844E03C",
            scanRecord: "1EFF06000109200208F9015C08B4884E465453D2B32A67431B1B1E6E03593B",
            timeStamp: 1720612659171
        )

        
        let objSampleData1 = SampleData.init(title: "Normal BLE device sample data", dataRecord: [objcustomBLE])
        let objSampleData2 = SampleData.init(title: "iBeacon sample data", dataRecord: [objiBeacon])
        let objSampleData3 = SampleData.init(title: "Eddystone(UID) sample data", dataRecord: [objEddystone])
        
        arrSampleData = [objSampleData1,objSampleData2,objSampleData3]
        tblSampleData.reloadData()
    }
}


// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension SampleDataVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSampleData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSampleData[section].isExpand ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SampleDataHeaderCell", for: indexPath) as! SampleDataHeaderCell
        
            cell.setData(obj: arrSampleData[indexPath.section])
            
            cell.buttonActionCallback = {
                let indexSet = IndexSet(integer: indexPath.section)
                self.tblSampleData.reloadSections(indexSet, with: .automatic)
            }
            return cell
            
        } else { // Data row
            let cell = tableView.dequeueReusableCell(withIdentifier: "SampleDataCell", for: indexPath) as! SampleDataCell
            cell.setData(arrObj: arrSampleData[indexPath.section].dataRecord)
            return cell
        }
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension SampleDataVC: UITableViewDelegate {
    
}

