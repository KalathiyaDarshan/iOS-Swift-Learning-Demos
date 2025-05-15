//
//  DocumentManager.swift
//  FileImportExport
//
//  Created by Apple on 04/10/24.
//

import UIKit
import UniformTypeIdentifiers

class DocumentManager: NSObject, UIDocumentPickerDelegate {
    
    // Singleton instance for easy access across the app if needed
    static let shared = DocumentManager()

    // Completion handler for passing the parsed data back to the ViewController
    var completion: (([ReadWriteData]?, Error?) -> Void)?

    // Function to present the document picker
    func presentDocumentPicker(from viewController: UIViewController, completion: @escaping ([ReadWriteData]?, Error?) -> Void) {
        self.completion = completion

        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.json])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        // Present the document picker from the provided view controller
        viewController.present(documentPicker, animated: true, completion: nil)
    }
    
    // UIDocumentPickerDelegate method to handle file selection
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            completion?(nil, NSError(domain: "DocumentManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "No file selected"]))
            return
        }

        // Call the readFile function to parse the selected file
        ReadWriteDataManager.shared.readFile(fileURL: selectedFileURL) { [weak self] (data, error) in
            // Pass the result back to the view controller via the completion handler
            self?.completion?(data, error)
        }
    }
    
    // Handle document picker cancel event (optional)
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        completion?(nil, NSError(domain: "DocumentManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Document picker was cancelled"]))
    }
}

