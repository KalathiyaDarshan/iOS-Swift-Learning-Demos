//
//  ClassFile.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 27/12/24.
//

import Foundation

class SampleData {
    let title: String
    let dataRecord: [SampleDataRecord]
    var isExpand: Bool
    
    init(title: String, dataRecord: [SampleDataRecord],isExpand: Bool = false) {
        self.title = title
        self.dataRecord = dataRecord
        self.isExpand = isExpand
    }
}

struct SampleDataRecord: Codable {
    var deviceName: String
    var deviceLogicalName: String
    var deviceMacAddress: String
    var deviceRssi: Int
    var deviceType: String
    var avgDistance: Double
    var advertiseInterval: Int
    var isConnectable: Bool
    var txPower: Int
    var nameSpace: String? // Eddystone
    var instanceld: String? // Eddystone
    var uuid: String? // iBeacon
    var major: Int? // iBeacon
    var minor: Int? // iBeacon
    var scanRecord: String
    var timeStamp: Int
    
    init(deviceName: String, deviceLogicalName: String, deviceMacAddress: String, deviceRssi: Int, deviceType: String, avgDistance: Double, advertiseInterval: Int, isConnectable: Bool, txPower: Int, nameSpace: String? = nil, instanceld: String? = nil, uuid: String? = nil, major: Int? = nil, minor: Int? = nil, scanRecord: String, timeStamp: Int) {
        self.deviceName = deviceName
        self.deviceLogicalName = deviceLogicalName
        self.deviceMacAddress = deviceMacAddress
        self.deviceRssi = deviceRssi
        self.deviceType = deviceType
        self.avgDistance = avgDistance
        self.advertiseInterval = advertiseInterval
        self.isConnectable = isConnectable
        self.txPower = txPower
        self.nameSpace = nameSpace
        self.instanceld = instanceld
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.scanRecord = scanRecord
        self.timeStamp = timeStamp
    }
}

class ServerDetail: Codable {
    var isUpload: Bool
    var isAllowDuplicateData: Bool
    var uploadFrequencySecond: Int
    var server : Server
    var urlHTTPS: String
    var isAuthHTTPS: Bool
    var token: String
    var urlMQTT: String
    var topic: String
    var isAuthMQTT: Bool
    var userName: String
    var password: String
    
    init(isUpload: Bool, isAllowDuplicateData: Bool, uploadFrequencySecond: Int, server: Server, urlHTTPS: String, isAuthHTTPS: Bool, token: String, urlMQTT: String, topic: String, isAuthMQTT: Bool, userName: String, password: String) {
        self.isUpload = isUpload
        self.isAllowDuplicateData = isAllowDuplicateData
        self.uploadFrequencySecond = uploadFrequencySecond
        self.server = server
        self.urlHTTPS = urlHTTPS
        self.isAuthHTTPS = isAuthHTTPS
        self.token = token
        self.urlMQTT = urlMQTT
        self.topic = topic
        self.isAuthMQTT = isAuthMQTT
        self.userName = userName
        self.password = password
    }

}
