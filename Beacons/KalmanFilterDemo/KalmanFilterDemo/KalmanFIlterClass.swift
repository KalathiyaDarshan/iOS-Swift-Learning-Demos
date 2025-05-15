//
//  KalmanFIlterClass.swift
//  KalmanFilterDemo
//
//  Created by Darshan Kalathiya on 23/12/24.
//

import Foundation

class KalmanFilter {
    private var estimate: Double
    private var errorCovariance: Double
    private var processNoise: Double
    private var measurementNoise: Double
    
    init(estimate: Double = 0.0, errorCovariance: Double = 1.0, processNoise: Double = 0.125, measurementNoise: Double = 0.8) {
        self.estimate = estimate
        self.errorCovariance = errorCovariance
        self.processNoise = processNoise
        self.measurementNoise = measurementNoise
    }
    
    func applyMeasurement(measurement: Double) -> Double {
        // Kalman gain
        let kalmanGain = errorCovariance / (errorCovariance + measurementNoise)
        
        // Update estimate
        estimate = estimate + kalmanGain * (measurement - estimate)

        // Update error covariance
        errorCovariance = (1 - kalmanGain) * errorCovariance + processNoise
        
        print("----estimate",estimate)
        print("----errorCovariance",errorCovariance)
        print("----processNoise",processNoise)
        print("----measurementNoise",measurementNoise)
        
        return estimate
    }
}
