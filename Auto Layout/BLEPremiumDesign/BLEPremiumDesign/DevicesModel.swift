//
//  BaseVC.swift
//  BLEScanner
//
//  Created by Bluepixel.
//

import Foundation
import UIKit

public enum Model: String {

//Simulator
case simulator     = "simulator/sandbox",

//iPod
iPod1              = "iPod 1",
iPod2              = "iPod 2",
iPod3              = "iPod 3",
iPod4              = "iPod 4",
iPod5              = "iPod 5",

//iPad
iPad2              = "iPad 2",
iPad3              = "iPad 3",
iPad4              = "iPad 4",
iPadAir            = "iPad Air ",
iPadAir2           = "iPad Air 2",
iPadAir3           = "iPad Air 3",
iPad5              = "iPad 5", //iPad 2017
iPad6              = "iPad 6", //iPad 2018
iPad7              = "iPad 7", //iPad 2019

//iPad Mini
iPadMini           = "iPad Mini",
iPadMini2          = "iPad Mini 2",
iPadMini3          = "iPad Mini 3",
iPadMini4          = "iPad Mini 4",
iPadMini5          = "iPad Mini 5",

//iPad Pro
iPadPro9_7         = "iPad Pro 9.7\"",
iPadPro10_5        = "iPad Pro 10.5\"",
iPadPro11          = "iPad Pro 11\"",
iPadPro12_9        = "iPad Pro 12.9\"",
iPadPro2_12_9      = "iPad Pro 2 12.9\"",
iPadPro3_12_9      = "iPad Pro 3 12.9\"",

//iPhone
iPhone4            = "iPhone 4",
iPhone4S           = "iPhone 4S",
iPhone5            = "iPhone 5",
iPhone5S           = "iPhone 5S",
iPhone5C           = "iPhone 5C",
iPhone6            = "iPhone 6",
iPhone6Plus        = "iPhone 6 Plus",
iPhone6S           = "iPhone 6S",
iPhone6SPlus       = "iPhone 6S Plus",
iPhoneSE           = "iPhone SE",
iPhone7            = "iPhone 7",
iPhone7Plus        = "iPhone 7 Plus",
iPhone8            = "iPhone 8",
iPhone8Plus        = "iPhone 8 Plus",
iPhoneX            = "iPhone X",
iPhoneXS           = "iPhone XS",
iPhoneXSMax        = "iPhone XS Max",
iPhoneXR           = "iPhone XR",
iPhone11           = "iPhone 11",
iPhone11Pro        = "iPhone 11 Pro",
iPhone11ProMax     = "iPhone 11 Pro Max",
iPhoneSE2          = "iPhone SE 2nd gen",

//Apple TV
AppleTV            = "Apple TV",
AppleTV_4K         = "Apple TV 4K",
unrecognized       = "?unrecognized?"
}

// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

public extension UIDevice {

var type: Model {
    var systemInfo = utsname()
    uname(&systemInfo)
    let modelCode = withUnsafePointer(to: &systemInfo.machine) {
        $0.withMemoryRebound(to: CChar.self, capacity: 1) {
            ptr in String.init(validatingUTF8: ptr)
        }
    }

    let modelMap: [String: Model] = [

        //Simulator
        "i386"     : .simulator,
        "x86_64"   : .simulator,

        //iPod
        "iPod1,1"  : .iPod1,
        "iPod2,1"  : .iPod2,
        "iPod3,1"  : .iPod3,
        "iPod4,1"  : .iPod4,
        "iPod5,1"  : .iPod5,

        //iPad
        "iPad2,1"  : .iPad2,
        "iPad2,2"  : .iPad2,
        "iPad2,3"  : .iPad2,
        "iPad2,4"  : .iPad2,
        "iPad3,1"  : .iPad3,
        "iPad3,2"  : .iPad3,
        "iPad3,3"  : .iPad3,
        "iPad3,4"  : .iPad4,
        "iPad3,5"  : .iPad4,
        "iPad3,6"  : .iPad4,
        "iPad6,11" : .iPad5, //iPad 2017
        "iPad6,12" : .iPad5,
        "iPad7,5"  : .iPad6, //iPad 2018
        "iPad7,6"  : .iPad6,
        "iPad7,11" : .iPad7, //iPad 2019
        "iPad7,12" : .iPad7,

        //iPad Mini
        "iPad2,5"  : .iPadMini,
        "iPad2,6"  : .iPadMini,
        "iPad2,7"  : .iPadMini,
        "iPad4,4"  : .iPadMini2,
        "iPad4,5"  : .iPadMini2,
        "iPad4,6"  : .iPadMini2,
        "iPad4,7"  : .iPadMini3,
        "iPad4,8"  : .iPadMini3,
        "iPad4,9"  : .iPadMini3,
        "iPad5,1"  : .iPadMini4,
        "iPad5,2"  : .iPadMini4,
        "iPad11,1" : .iPadMini5,
        "iPad11,2" : .iPadMini5,

        //iPad Pro
        "iPad6,3"  : .iPadPro9_7,
        "iPad6,4"  : .iPadPro9_7,
        "iPad7,3"  : .iPadPro10_5,
        "iPad7,4"  : .iPadPro10_5,
        "iPad6,7"  : .iPadPro12_9,
        "iPad6,8"  : .iPadPro12_9,
        "iPad7,1"  : .iPadPro2_12_9,
        "iPad7,2"  : .iPadPro2_12_9,
        "iPad8,1"  : .iPadPro11,
        "iPad8,2"  : .iPadPro11,
        "iPad8,3"  : .iPadPro11,
        "iPad8,4"  : .iPadPro11,
        "iPad8,5"  : .iPadPro3_12_9,
        "iPad8,6"  : .iPadPro3_12_9,
        "iPad8,7"  : .iPadPro3_12_9,
        "iPad8,8"  : .iPadPro3_12_9,

        //iPad Air
        "iPad4,1"  : .iPadAir,
        "iPad4,2"  : .iPadAir,
        "iPad4,3"  : .iPadAir,
        "iPad5,3"  : .iPadAir2,
        "iPad5,4"  : .iPadAir2,
        "iPad11,3" : .iPadAir3,
        "iPad11,4" : .iPadAir3,
        

        //iPhone
        "iPhone3,1": .iPhone4,
        "iPhone3,2": .iPhone4,
        "iPhone3,3": .iPhone4,
        "iPhone4,1": .iPhone4S,
        "iPhone5,1": .iPhone5,
        "iPhone5,2": .iPhone5,
        "iPhone5,3": .iPhone5C,
        "iPhone5,4": .iPhone5C,
        "iPhone6,1": .iPhone5S,
        "iPhone6,2": .iPhone5S,
        "iPhone7,1": .iPhone6Plus,
        "iPhone7,2": .iPhone6,
        "iPhone8,1": .iPhone6S,
        "iPhone8,2": .iPhone6SPlus,
        "iPhone8,4": .iPhoneSE,
        "iPhone9,1": .iPhone7,
        "iPhone9,3": .iPhone7,
        "iPhone9,2": .iPhone7Plus,
        "iPhone9,4": .iPhone7Plus,
        "iPhone10,1": .iPhone8,
        "iPhone10,4": .iPhone8,
        "iPhone10,2": .iPhone8Plus,
        "iPhone10,5": .iPhone8Plus,
        "iPhone10,3": .iPhoneX,
        "iPhone10,6": .iPhoneX,
        "iPhone11,2": .iPhoneXS,
        "iPhone11,4": .iPhoneXSMax,
        "iPhone11,6": .iPhoneXSMax,
        "iPhone11,8": .iPhoneXR,
        "iPhone12,1": .iPhone11,
        "iPhone12,3": .iPhone11Pro,
        "iPhone12,5": .iPhone11ProMax,
        "iPhone12,8": .iPhoneSE2,

        //Apple TV
        "AppleTV5,3": .AppleTV,
        "AppleTV6,2": .AppleTV_4K
    ]

    if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
        if model == .simulator {
            if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                    return simModel
                }
            }
        }
        return model
    }
    return Model.unrecognized
  }
}

class DeviceManager: NSObject {

    static let height = UIScreen.main.bounds.size.height

    class func isIphone4OR4s() -> Bool {
        
        if height == 480.0 {
            
            return true
        }
        return false
    }
    class func isIphone5OR5cOR5sORSE() -> Bool {
        
        if height == 568.0 {
            
            return true
        }
        return false
    }
    class func isIphone6OR6SOR7OR8() -> Bool {
        
        if height == 667.0 {
            
            return true
        }
        return false
    }
    class func isIphone6PlusOR6SPlusOR7PlusOR8Plus() -> Bool {
        
        if height == 736.0 {
            
            return true
        }
        return false
    }
    class func isIphoneX() -> Bool {
        
        if height == 812.0 {
            
            return true
        }
        return false
    }
    class func isIPad() -> Bool {
        
        if height > 812.0 {
            
            return true
        }
        return false
    }
    class func GetAutoFontSize(minFontZie: CGFloat) -> CGFloat {
        
        if isIphone4OR4s() {
            return minFontZie - ((minFontZie * 20) / 100)
        } else if isIphone5OR5cOR5sORSE() {
            return minFontZie - ((minFontZie * 10) / 100)
        } else if isIphone6OR6SOR7OR8() {
            return minFontZie //+ ((minFontZie * 20) / 100)
        } else if isIphone6PlusOR6SPlusOR7PlusOR8Plus() {
            return minFontZie + ((minFontZie * 30) / 100)
        } else if isIphoneX() {
            return minFontZie + ((minFontZie * 40) / 100)
        } else {
            return minFontZie + ((minFontZie * 50) / 100)
        }
    }
}
