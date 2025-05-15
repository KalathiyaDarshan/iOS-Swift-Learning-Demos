//
//  UserLocalData.swift
//  UBFit
//
//  Created by mac on 01/08/24.
//

import Foundation

final class UserLocalData {
    
    private enum DataKey: String {
        case userId
    }
    
    static var saveUserId: String {
        get {
            return UserDefaults.standard.string(forKey: DataKey.userId.rawValue) ?? ""
        }set {
            UserDefaults.standard.set(newValue, forKey: DataKey.userId.rawValue)
        }
    }
}
