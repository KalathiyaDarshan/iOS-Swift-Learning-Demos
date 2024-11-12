//
//  UserLocalData.swift
//  ShopingListProject
//
//  Created by mac on 18/06/24.
//

import Foundation

final class UserDataManager {
    
    private enum DataKey: String {
        
        case saveRecord
    }
    
    // Save One Record
    static var saveRecord: [MainShopingList] {
        get {
            if let data = UserDefaults.standard.data(forKey: DataKey.saveRecord.rawValue) {
                do {
                    let decodedList = try JSONDecoder().decode([MainShopingList].self, from: data)
                    return decodedList
                } catch {
                    print("Failed to decode record: \(error)")
                    return []
                }
            }
            return []
        }
        set {
            self.saveArrayToUserDefault(arrData: newValue)
        }
    }
    
    static func saveArrayToUserDefault(arrData: [MainShopingList])
    {
        do {
            let encodedData = try JSONEncoder().encode(arrData)
            UserDefaults.standard.set(encodedData, forKey: DataKey.saveRecord.rawValue)
            UserDefaults.standard.synchronize()
        } catch {
            print("Failed to encode records: \(error)")
        }
    }
    
    // Update Record
    static func updateRecord(with updatedList: MainShopingList) {
        var list = saveRecord
        if let index = list.firstIndex(where: { $0.id == updatedList.id }) {
            list[index] = updatedList
            saveRecord = list
        } else {
            print("Updated Record with id \(updatedList.id) not found")
        }
    }

    
    static func clearAllUserData() {
        
        let defaults = UserDefaults.standard
        
        let keysToRemove: [String] = [DataKey.saveRecord.rawValue]
        
        for key in keysToRemove {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    // Remove One Record
    static func removeRecord(at index: Int) {
        var record = saveRecord
        if index >= 0 && index < record.count {
            record.remove(at: index)
            saveRecord = record
        } else {
            print("Index out of range")
        }
    }

}

