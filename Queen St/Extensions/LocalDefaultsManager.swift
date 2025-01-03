
import Foundation
import SwiftyJSON

class LocalDefaultsManager: NSObject {

    static let sharedUserDefaults = UserDefaults.standard
    
    static var deviceToken: String? {
        get {
            return sharedUserDefaults.string(forKey: "APNSDeviceToken")
        } set {
            sharedUserDefaults.removeObject(forKey: "APNSDeviceToken")
            sharedUserDefaults.set(newValue, forKey: "APNSDeviceToken")
            sharedUserDefaults.synchronize()

        }
    }
    
    static var userLoggedIn: Bool {
        get {
            return sharedUserDefaults.bool(forKey: "userLoggedIn")
        }
        set{
            sharedUserDefaults.removeObject(forKey: "userLoggedIn")
            sharedUserDefaults.set(newValue, forKey: "userLoggedIn")
            sharedUserDefaults.synchronize()
        }
    }
  
    
   
}

