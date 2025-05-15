//
//  UserDefaultUtils.swift
//  BLEScanner
//
//  Created by Bluepixel.
//

import Foundation

let objUserDefaultUtils = UserDefaultUtils.shared
let userDefault = UserDefaults.standard

enum DefaultKey: String {
    case kAuthToken                             = "auth_token"
    case kFCMToken                              = "fcm_token"
    case kUserId                                = "userId"
    case kAppLanguageCode                       = "AppLanguageCode"
    
    case kFilterName                            = "FilterName"
    case kFilterRssi                            = "FilterRssi"
    case kFilterServiceUUID                     = "FilterServiceUUID"
    case kisContineousScanning                  = "isContineousScanning"
    case kManualScanningSec                      = "ManualScanningSec"
    
    case kIsScanning                            = "isScanning"
    case kIsiBeaconScanning                     = "kIsiBeaconScanning"
    case kBeaconUUID                            = "BeaconUUID"
    case kBeaconMajor                           = "BeaconMajor"
    case kBeaconMinor                           = "BeaconMinor"
    case kAdvertisingDeviceID                   = "AdvertisingDeviceID"
    
    // in app purchase
    case kSubscriptionID                       = "SubscriptionID"
    case kSubscriptionExpiryDate               = "SubscriptionExpiryDate"
    case kIsIAPReceiptFetched                  = "isIAPReceiptFetched"
    case kAliasNamesDictionary                 = "AliasNamesDictionary"
    
    // Tooltip
    case kScanning                              = "Scanning"
    case kRadar                                 = "Radar"
    case kQR                                    = "QR"
    case kAdvertiser                            = "Advertiser"
    case kProximityAlert                            = "ProximityAlert"
    case kIsIntroDone                            = "kIsIntroDone"
    
    case kNewTutorial                            = "NewTutorial"
    case kShouldReloadList                            = "ShouldReloadList"
    case kSideMenuNewItem                            = "SideMenuNewItem"
    
    //MARK: changed
    // Server
  case KServerConfiguration                   = "ServerConfiguration"
    
}

class UserDefaultUtils: NSObject {
    
    static let shared = UserDefaultUtils()
    fileprivate override init() { }
    
    var AdvertisingDeviceID: Int {
        get {
            return self.getUserDefaultIntRssiFromKey(.kAdvertisingDeviceID)
        }
        set {
            self.saveIntoUserDefaultInt(value: newValue, key: .kAdvertisingDeviceID)
        }
    }
    
    var isScanning: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kIsScanning)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kIsScanning)
        }
    }
    
    var isiBeaconScanning: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kIsiBeaconScanning)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kIsiBeaconScanning)
        }
    }
    
    var isContineousScanning: Bool {
        get {
            return self.getUserDefaultBoolforcontinuousFromKey(.kisContineousScanning)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kisContineousScanning)
        }
    }
    
    var ManualScanningSec: Int {
        get {
            return self.getUserDefaultIntFromKey(.kManualScanningSec)
        }
        set {
            self.saveIntoUserDefaultInt(value: newValue, key: .kManualScanningSec)
        }
    }
   
    var FilterName: String {
        get {
            return self.getUserDefaultStringFromKey(.kFilterName)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kFilterName)
        }
    }
    
    var FilterServiceUUID: String {
        get {
            return self.getUserDefaultStringFromKey(.kFilterServiceUUID)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kFilterServiceUUID)
        }
    }
    
    var FilterRssi: Int {
        get {
            return self.getUserDefaultIntRssiFromKey(.kFilterRssi)
        }
        set {
            self.saveIntoUserDefaultInt(value: newValue, key: .kFilterRssi)
        }
    }
    
    var FCMToken: String {
        get {
            return self.getUserDefaultStringFromKey(.kFCMToken)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kFCMToken)
        }
    }
    
    var authToken: String {
        get {
            return self.getUserDefaultStringFromKey(.kAuthToken)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kAuthToken)
        }
    }
  
    var userId: String {
        get {
            return self.getUserDefaultStringFromKey(.kUserId)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kUserId)
        }
    }
   
    var appLanguageCode: String {
        get {
            return self.getUserDefaultStringFromKey(.kAppLanguageCode)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kAppLanguageCode)
        }
    }
    
    var beaconUUID: String {
        get {
            return self.getUserDefaultStringFromKey(.kBeaconUUID)
        }
        set {
            self.saveIntoUserDefaultString(value: newValue, key: .kBeaconUUID)
        }
    }
    
    var beaconMinor: Int? {
        get {
            return self.getUserDefaultOptionalIntFromKey(.kBeaconMinor)
        }
        set {
            self.saveIntoUserDefaultOptionalInt(value: newValue, key: .kBeaconMinor)
        }
    }
    
    var beaconMajor: Int? {
        get {
            return self.getUserDefaultOptionalIntFromKey(.kBeaconMajor)
        }
        set {
            self.saveIntoUserDefaultOptionalInt(value: newValue, key: .kBeaconMajor)
        }
    }
    
    var isIAPReceiptFetched: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kIsIAPReceiptFetched)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kIsIAPReceiptFetched)
        }
    }
    
    var proximityAlert: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kProximityAlert)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kProximityAlert)
        }
    }
    
    var isIntroDone: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kIsIntroDone)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kIsIntroDone)
        }
    }
    
    var NewTutorial: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kNewTutorial)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kNewTutorial)
        }
    }
    
    var shouldReloadList: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kShouldReloadList)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kShouldReloadList)
        }
    }
    
    var SideMenuNewItem: Bool {
        get {
            return self.getUserDefaultBoolFromKey(.kSideMenuNewItem)
        }
        set {
            self.saveIntoUserDefaultBool(value: newValue, key: .kSideMenuNewItem)
        }
    }
    
    var dictAliasNames: [String: Any] {
        get {
            return self.getUserDefaultDictFromKey(.kAliasNamesDictionary)
        }
        set {
            self.saveIntoUserDefaultDictionary(value: newValue, key: .kAliasNamesDictionary)
        }
    }
    
    //MARK: changed
    
    var serverDetail: ServerDetail {
        get {
            // Retrieve the object from UserDefaults
            if let value = self.getObject(forKey: .KServerConfiguration, objectType: ServerDetail.self) {
                return value
            }
            // Return a default instance if not found
            return ServerDetail.init(isUpload: false, isAllowDuplicateData: true, uploadFrequencySecond: 5, server: .https, urlHTTPS: "", isAuthHTTPS: false, token: "", urlMQTT: "", topic: "", isAuthMQTT: false, userName: "", password: "")
        }
        set {
            // Save the object to UserDefaults
            self.saveObject(newValue, forKey: .KServerConfiguration)
        }
    }

    func saveObject<T: Codable>(_ object: T, forKey key: DefaultKey) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            userDefault.set(encoded, forKey: key.rawValue)
            userDefault.synchronize()
        }
    }

    func getObject<T: Codable>(forKey key: DefaultKey, objectType: T.Type) -> T? {
        if let data = userDefault.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            return try? decoder.decode(objectType, from: data)
        }
        return nil
    }
    
    func saveIntoUserDefaultString(value: String, key: DefaultKey) {
        userDefault.setValue(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultStringFromKey(_ key: DefaultKey) -> String {
        
        var value: String = String()
        
        if  (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.string(forKey: key.rawValue) ?? ""
            return value
        }
        return value
    }
    
    func saveIntoUserDefaultBool(value: Bool, key: DefaultKey) {
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultBoolFromKey(_ key: DefaultKey) -> Bool {
        
        var value: Bool = Bool()
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.bool(forKey: key.rawValue)
            return value
        }
        return value
    }
    
    func saveIntoUserDefaultDict(value: [String: Any], key: DefaultKey) {
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultDictFromKey(_ key: DefaultKey) -> [String: Any] {
        
        var value = [String: Any]()
        
        if let val = userDefault.value(forKey: key.rawValue) as? [String: Any] {
            value = val
            return value
        }
        return value
    }
    
    func getUserDefaultBoolforcontinuousFromKey(_ key: DefaultKey) -> Bool {
        
        var value: Bool = true
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.bool(forKey: key.rawValue)
            return value
        }
        return value
    }
    
    func saveIntoUserDefaultInt(value: Int, key: DefaultKey) {
        
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func saveIntoUserDefaultOptionalInt(value: Int?, key: DefaultKey) {
        
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultIntFromKey(_ key: DefaultKey) -> Int {
        
        var value: Int = Int()
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.integer(forKey: key.rawValue)
            return value
        }
        return value
    }
    
    func getUserDefaultOptionalIntFromKey(_ key: DefaultKey) -> Int? {
        
        var value: Int?
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.integer(forKey: key.rawValue)
            return value
        }
        return value
    }
    
    func getUserDefaultIntRssiFromKey(_ key: DefaultKey) -> Int {
        
        var value: Int = Int()
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.integer(forKey: key.rawValue)
            return value
        }
        return 1
    }
    
    
    func saveIntoUserDefaultDouble(value: Double, key: DefaultKey) {
        
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultDoubleFromKey(_ key: DefaultKey) -> Double {
        
        var value: Double = Double()
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            value = userDefault.double(forKey: key.rawValue)
            return value
        }
        return value
    }
    
    
    func saveIntoUserDefaultDictionary(value: [String:Any], key: DefaultKey) {
        userDefault.setValue(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultDictionaryFromKey(_ key: DefaultKey) -> [String: Any]? {
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            return userDefault.object(forKey: key.rawValue) as? [String: Any]
        }
        return nil
    }
    
    
    func saveIntoUserDefaultAny(value: Any, key: DefaultKey) {
        userDefault.setValue(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func getUserDefaultAnyFromKey(_ key: DefaultKey) -> Any? {
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            return userDefault.object(forKey: key.rawValue)
        }
        return nil
    }
    
    
    func saveIntoUserDefaultDecoable<T: Encodable>(value: T, key: DefaultKey) {
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(value)
            userDefault.setValue(encodedData, forKey: key.rawValue)
            userDefault.synchronize()
            
        } catch {
            debugPrint("Error in Storing \(#function)")
        }
    }
    
    func getUserDefaultDecoableFromKey<T: Decodable>(_ key: DefaultKey, type: T.Type) -> T? {
        
        if (userDefault.value(forKey: key.rawValue) != nil), let data = userDefault.object(forKey: key.rawValue) as? Data {
            
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode(T.self, from: data) {
                debugPrint(loaded)
                return loaded
            }
            
        } else {
            debugPrint("Error in getting \(#function)")
        }
        return nil
    }
    
    
    func saveArrayDecoable<T: Encodable>(value: [T], key: DefaultKey) {
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(value)
            userDefault.setValue(encodedData, forKey: key.rawValue)
            userDefault.synchronize()
            
        } catch {
            debugPrint("Error in Storing \(#function)")
        }
    }
    
    func getArrayDecoableFromKey<T: Decodable>(_ key: DefaultKey, type: [T].Type) -> [T]? {
        
        if (userDefault.value(forKey: key.rawValue) != nil), let data = userDefault.object(forKey: key.rawValue) as? Data {
            
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode([T].self, from: data) {
                debugPrint(loaded)
                return loaded
            }
            
        } else {
            debugPrint("Error in getting \(#function)")
        }
        return nil
    }
    
    
    func removeUserDefault(key: DefaultKey) {
        userDefault.removeObject(forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func isExistUserDefaultKey(_ key: DefaultKey) -> Bool {
        
        if (userDefault.value(forKey: key.rawValue) != nil) {
            return true
        }
        return false
    }
}

//MARK: - change
enum Server: String,Codable {
    case https = "HTTPS"
    case mqtt = "MQTT"
}
