// ReadWriteDataManager.swift
// FileImportExport
//
// Created by Apple on 03/10/24.

import Foundation

class ReadWriteDataManager {
    
    static let shared = ReadWriteDataManager()  // Singleton for easy access
    private init() {}  // Private init to ensure singleton usage
    
    private let fileName = "readWriteData.json"
    
    // Save an array of ReadWriteData to a JSON file
    func saveData(_ data: [ReadWriteData]) -> URL? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            // Encode the data into JSON format
            let jsonData = try encoder.encode(setDataToModel(objs: data))
            let fileURL = getFileURL() // Function to get the file URL
            
            // Write the data to the file
            try jsonData.write(to: fileURL)
            print("Data successfully saved to: \(fileURL.path)")
            
            // Return the file URL for sharing
            return fileURL
            
        } catch {
            print("Error saving data to JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Clear the JSON file (delete it)
    func clearData() {
        let fileURL = getFileURL()
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Data successfully cleared from: \(fileURL.path)")
        } catch {
            print("Error clearing data: \(error.localizedDescription)")
        }
    }
    
    // Helper function to get the file URL in the Documents directory
    private func getFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    private func setDataToModel(objs: [ReadWriteData]) -> [MiddleModel] {
        return objs.map { obj in
            let middleModel = MiddleModel(
                tagProfileName: obj.cellName,
                tagProfileDate: getCurrentDateFormatted(),
                tagProfileLength: 1,
                tagProfileSize: Int(obj.textSize)
            )
            return middleModel
        }
    }
    
    // Read and parse the file content
    func readFile(fileURL: URL, completion: @escaping ([ReadWriteData]?, Error?) -> Void) {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            
            // Decode the JSON data into an array of MiddleModel
            let middleModels = try decoder.decode([MiddleModel].self, from: jsonData)
            
            var arrData: [ReadWriteData] = []
            
            // Convert MiddleModel array to ReadWriteData array
            for model in middleModels {
                let objReadWriteData = ReadWriteData(
                    cellName: model.tagProfileName,
                    cellType: "",
                    recordType: "",
                    subtitles: "",
                    textSize: Int16(model.tagProfileSize)
                )
                arrData.append(objReadWriteData)
            }
            
            // Pass the parsed data back
            completion(arrData, nil)
        } catch let error {
            // Pass the error back
            completion(nil, error)
        }
    }
    

    private func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}
