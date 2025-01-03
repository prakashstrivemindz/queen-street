
import Foundation
import UIKit
import Alamofire

struct globalObject {
    static let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
    static let DeviceUUID = UIDevice.current.identifierForVendor!.uuidString
}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

struct globalColor {
    static let theme_color = "000000"
    static let tabbar_text_color = "D7BE69"
}

struct APP
{
    static var appName = "Queen Street"
    static var loadingString = "Loading..."
    static var messageSomethingWrong = "Something went wrong"
    static var noRecordsFound = "No record found..."
}

struct globalDeviceType
{
    static var android = "android"
    static var ios = "ios"
}

