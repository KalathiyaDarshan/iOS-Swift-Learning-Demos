//
//  ViewController.swift
//  FileImportExport
//
//  Created by Apple on 03/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblUrl: UILabel!
    
    var arrData: [ReadWriteData] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUrl.text = "File Name"
        
        createJsonFile()
    }
    
    func createJsonFile() {
        
        let data1 = ReadWriteData(cellName: "Name1", cellType: "Type1", recordType: "Record1", subtitles: "Sub1", textSize: 50)
        let data2 = ReadWriteData(cellName: "Name2", cellType: "Type2", recordType: "Record2", subtitles: "Sub2", textSize: 20)
        arrData.append(contentsOf: [data1, data2])
        
        // Save data to JSON
        if let fileURL = ReadWriteDataManager.shared.saveData(arrData) {
            shareJsonFile(fileURL: fileURL)
        }
        
        // Clear data from JSON file (if needed)
        // ReadWriteDataManager.shared.clearData()
    }

    private func shareJsonFile(fileURL: URL) {
        // Initialize the activity view controller with the file URL
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        
        // Present the activity view controller
        // For iPads, this is needed to avoid crashes (UIPopoverController error)
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    func selectFileAndHandleResponse() {
           // Present the document picker via the DocumentManager
           DocumentManager.shared.presentDocumentPicker(from: self) { [weak self] (data, error) in
               if let error = error {
                   // Handle the error
                   print("Error: \(error.localizedDescription)")
                   return
               }

               if let data = data {
                   // Set the first file name on the label (if applicable)
                   self?.lblUrl.text = data.first?.cellName
                   
                   // Update your data array with parsed ReadWriteData objects
                   self?.arrData = data
                   print("arrData: ", self?.arrData.first?.cellName ?? "No data")
               }
           }
       }
    
    @IBAction func btnSelectFile(_ sender: UIButton) {
        selectFileAndHandleResponse()
    }
    
}
