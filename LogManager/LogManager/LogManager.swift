//
//  LogManager.swift
//  LogManager
//
//  Created by Darshan Kalathiya on 09/07/25.
//

import Foundation
import UIKit

class LogManager {
    
    static let shared = LogManager()
    
    private let fileName: String = {
        let projectName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "App"
        return "\(projectName.lowercased())_log.txt"
    }()
    
    private var logFileURL: URL? {
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let logsDirectory = documentDirectory.appendingPathComponent("Logs")
            
            if !fileManager.fileExists(atPath: logsDirectory.path) {
                try? fileManager.createDirectory(at: logsDirectory, withIntermediateDirectories: true, attributes: nil)
            }
                        
            return logsDirectory.appendingPathComponent(fileName)
        }
        return nil
    }
    
    private init() {}
    
    func addLog(_ message: String,shouldShowLineAt: LinePosition = .none) {
        guard let logFileURL = logFileURL else {
            print("⚠️ Log file URL not available")
            return
        }
        
        let timestamp = currentTimeString()
        
        let line: String = "------------------------------------------------------\n"
        var logEntry: String = ""
        
        switch shouldShowLineAt {
            case .before:
                logEntry = "\(line)[\(timestamp)] \(message)\n"
                
            case .after:
                logEntry = "[\(timestamp)] \(message)\n\(line)"
                
            case .both:
                logEntry = "\(line)[\(timestamp)] \(message)\n\(line)"
                
            case .none:
                logEntry = "[\(timestamp)] \(message)\n"
        }

        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: logFileURL.path) {
            fileManager.createFile(atPath: logFileURL.path, contents: nil, attributes: nil)
            deviceInformationLog()
        }
        
        if let data = logEntry.data(using: .utf8),
           let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
            defer { fileHandle.closeFile() }
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        }
        
#if DEBUG
        print("Log Entry: \(logEntry)")
#endif
    }
    
    private func currentTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
    
    func deleteLogFile() {
        if let url = logFileURL {
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    func getLogFilePath() -> String? {
        return logFileURL?.path
    }
    
    private func deviceInformationLog() {
        addLog("*** DEVICE INFORMATION ***",shouldShowLineAt: .before)
        let device = UIDevice.current
        addLog("App Bundle ID: \(Bundle.main.bundleIdentifier ?? "Unknown")")
        addLog("App Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")\(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown")")
        addLog("Device Name: \(device.name)")
        addLog("Device Model: \(device.model)")
        addLog("System: \(device.systemName) \(device.systemVersion)",shouldShowLineAt: .after)
    }

}

func addLog(_ log: String,shouldShowLineAt: LinePosition = .none) {
    LogManager.shared.addLog(log,shouldShowLineAt: shouldShowLineAt)
}

enum LinePosition {
    case before
    case after
    case both
    case none
}
