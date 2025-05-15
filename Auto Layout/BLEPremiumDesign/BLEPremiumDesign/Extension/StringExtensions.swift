//
//  StringExtensions.swift
//  WiralLite
//
//  Created by Bluepixel.
//  Copyright © 2024 Bluepixel. All rights reserved.


import Foundation
import UIKit

public extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,20}"
        
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: self)
    }
    
    func trime() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    func isValidurl() -> Bool {
        
        // create NSURL instance
        if let url = URL(string: self) {
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url)
        }else{
            return false
        }
    }

    //MARK: Changed
    func isValidURLFormat() -> Bool {
        let urlRegEx = "(https?://)?([a-z0-9]+[.])?[a-z0-9-]+[.][a-z]{2,6}([/\\w \\.-]*)*/?"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: self)
    }

    func trim(prefix: String) -> String {
        return hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }
    
    /// Standard hex prefix
    var hexPrefix: String { return "0x" }
    
    /// Converts string to Int value
    var integerValue: Int { return strtol(self, nil, 10) }
    
    /// Converts string to UInt value
    var uintegerValue: UInt { return strtoul(self, nil, 10) }
    
    /// Converts string to Bool value
    var booleanValue: Bool { return integerValue != 0 }
    
    /// Converts string to hex value. This supports 0x, 0X prefix if present
    var hexValue: Int? {
        return Int(trim(prefix: hexPrefix).trim(prefix: "0X"), radix: 16)
    }
    
    /// Converts string to unsigned hex value. This supports 0x prefix if present
    var uHexValue: UInt? {
        return UInt(trim(prefix: hexPrefix).trim(prefix: "0X"), radix: 16)
    }
    
    var hexaBytes: [UInt8] {
        var position = startIndex
        return (0..<count/2).compactMap { _ in
            defer { position = index(position, offsetBy: 2) }
            return UInt8(self[position...index(after: position)], radix: 16)
        }
    }
    
    var hexaData: Data { return hexaBytes.data }
    
    //    var bytes: Array<UInt8> {
    //        return data(using: String.Encoding.utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    //    }
    
    /// Left pads string to at least `minWidth` characters wide
    func leftPad(_ character: Character, toWidth minWidth: Int) -> String {
        guard minWidth > self.count else { return self }
        return String(repeating: String(character), count: minWidth - self.count) + self
    }
    
    
  /*
        func appendLineToURL(fileURL: URL) throws {
            try (self).appendToURL(fileURL: fileURL)
        }
    
        func appendToURL(fileURL: URL) throws {
            let data = self.data(using: String.Encoding.utf8)!
            try data.append(fileURL: fileURL)
        }
  */
    
    
    func validateName() -> Bool
    {
        let NameRegEx = "[a-z A-Z]+"
        let NameTest = NSPredicate(format:"SELF MATCHES %@", NameRegEx)
        return NameTest.evaluate(with: self)
    }
    
    func convertDateFormatFromString(strDate: String, currentFormat : String = "yyyy-MM-dd", newFormat : String = "dd-MM-yyyy") -> String {
        
        if !strDate.isEmpty {
            
            let olDateFormatter = DateFormatter()
            olDateFormatter.dateFormat = currentFormat
            
            let oldDate = olDateFormatter.date(from: strDate)
            
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = newFormat
            
            return convertDateFormatter.string(from: oldDate!)
        } else {
            return ""
        }
    }
    
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        //df.timeZone = TimeZone.utc
        return df.date(from: self)
    }
    
    func toDateTimezon(format: String , timezon : TimeZone) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = timezon
        return df.date(from: self)
    }
    
    func toDatelocal(format: String) -> Date? {
      
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter.date(from: self)
        
    }
    
    func reverse() -> String {
        var str = ""
        for character in Array(self)  {
            str = "\(character)" + str
        }
        return str
    }
    
    static func binaryRepresentation<F: FixedWidthInteger>(of val: F) -> String {

        let binaryString = String(val, radix: 2)

        if val.leadingZeroBitCount > 0 {
            return String(repeating: "0", count: val.leadingZeroBitCount) + binaryString
        }

        return binaryString
    }
  
    func stringAt(_ i: Int) -> String {
      return String(Array(self)[i]) + String(Array(self)[i + 1])
    }
    
    var parseJSONString: AnyObject? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray {
                    print(jsonResult)
                    
                    return jsonResult //Will return the json array output
                } else {
                    return nil
                }
            } catch let error as NSError {
                print("An error occurred: \(error)")
                return nil
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    func insertSeparator(_ separatorString: String, atEvery n: Int) -> String {
        guard 0 < n else { return self }
        return self.enumerated().map({String($0.element) + (($0.offset != self.count - 1 && $0.offset % n ==  n - 1) ? "\(separatorString)" : "")}).joined()
    }
    
    mutating func insertedSeparator(_ separatorString: String, atEvery n: Int) {
        self = insertSeparator(separatorString, atEvery: n)
    }
}
extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}

extension String {
    func htmlToAttributedString(with attribut: [NSAttributedString.DocumentReadingOptionKey : Any] = [:]) -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            var options: [NSAttributedString.DocumentReadingOptionKey : Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue]
            for i in attribut {
                options[i.key] = i.value
            }
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont?, csscolor: String, lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return htmlToAttributedString()
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
