//
//  BeaconRecord.swift
//  BeaconIntegrationDemo
//
//  Created by Darshan Kalathiya on 19/12/24.
//
import Foundation
import UIKit

class BeaconRecord {
    var rssi: Int
    var kalmanFilterRSSI: Int
    var averageRSSI: Int
    let uuid: UUID
    let major: NSNumber
    let minor: NSNumber
    var distance: Double
    var timeStamp: Date
    var kalmanFilterObj: KalmanFilter
    var arrKalmanFilterRSSI: [Int]

    init(rssi: Int, uuid: UUID, major: NSNumber, minor: NSNumber, timeStamp: Date) {
        self.rssi = rssi
        self.kalmanFilterObj = KalmanFilter()
        self.kalmanFilterRSSI = Int(kalmanFilterObj.applyMeasurement(measurement: Double(rssi)))
        self.averageRSSI = kalmanFilterRSSI
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.timeStamp = timeStamp
        self.distance = 0.0 // Temporary default value
        self.arrKalmanFilterRSSI = [kalmanFilterRSSI]
        
        // Now, call the method to calculate distance after initialization
        self.distance = calculateDistanceFromRSSI(rssi: self.averageRSSI)
    }
    
    // Method to update RSSI and recalculate distance
    func updateRSSI(rssi: Int,timeStamp: Date) {
        self.rssi = rssi
        self.kalmanFilterRSSI = Int(kalmanFilterObj.applyMeasurement(measurement: Double(rssi)))
        self.averageRSSI = applyAverageFilter(rssi: self.kalmanFilterRSSI)
        self.distance = calculateDistanceFromRSSI(rssi: averageRSSI) // Recalculate distance after update
        self.timeStamp = timeStamp
    }
    
    // Method to calculate distance from RSSI
    private func calculateDistanceFromRSSI(rssi: Int) -> Double {
        let txPower = -59 // Default TX power for most beacons
        if rssi == 0 { return -1.0 } // No signal
        
        let ratio = rssi / txPower
        let distance: Double
        if ratio < 1 {
            distance = pow(10.0, (Double(txPower) - Double(rssi)) / 20.0)
        } else {
            distance = pow(10.0, (Double(txPower) - Double(rssi)) / 10.0)
        }
        
        // Round to 2 decimal places
        let roundedDistance = Double(String(format: "%.2f", distance)) ?? distance
        return roundedDistance
    }
    
    private func applyAverageFilter(rssi: Int) -> Int {
        // Append the new RSSI value to the array
        self.arrKalmanFilterRSSI.append(rssi)
        
        // Ensure the array doesn't exceed 10 elements
        if self.arrKalmanFilterRSSI.count > 10 {
            self.arrKalmanFilterRSSI.removeFirst()
        }
        print("arrKalmanFilterRSSI: ",arrKalmanFilterRSSI)

        // Step 1: Sort the array
        let sortedArray = self.arrKalmanFilterRSSI.sorted()
        print("sortedArray: ",sortedArray)
        
        // Step 2: Remove the first 20% and last 20%
        let count = sortedArray.count
        let start = Int(Double(count) * 0.2)
        let end = count - start
        let trimmedArray = sortedArray[start..<end]
        
        print("trimmedArray: ",trimmedArray)
        
        // Step 3: Calculate the average of the remaining elements
        let sum = trimmedArray.reduce(0, +)
        let average = trimmedArray.isEmpty ? 0 : sum / trimmedArray.count
        
        return average
    }

//    func applyAverageFilter(rssi: Int) -> Int{
//        self.arrKalmanFilterRSSI.append(rssi)
//
//        if self.arrKalmanFilterRSSI.count > 10 {self.arrKalmanFilterRSSI.removeFirst() }
//        let average = self.arrKalmanFilterRSSI.reduce(0, +) / self.arrKalmanFilterRSSI.count
//
//        return average
//    }
}
