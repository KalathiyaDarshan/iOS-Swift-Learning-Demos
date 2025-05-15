//
//  ViewController.swift
//  KalmanFilterDemo
//
//  Created by Darshan Kalathiya on 23/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create an instance of KalmanFilter
        let kalmanFilter = KalmanFilter()
        
        // Simulate noisy sensor data
        let noisyMeasurements = [-50, -52, 0, -59, -63, -59, -62, -55, 0, -53]
        
        // Apply Kalman Filter on each measurement
        for measurement in noisyMeasurements {
            let filteredValue = kalmanFilter.applyMeasurement(measurement: Double(measurement))
            print("Measured: \(measurement), Filtered: \(filteredValue)")
           // print("...")
        }
    }


}

