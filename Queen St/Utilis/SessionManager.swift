

import Foundation

class SessionManager: NSObject {
    
    public static let shared = SessionManager()

    private let kSESSION_DEVICETOKEN_KEY = "kSessionDeviceTokenKey"
    private let kSESSION_FCM_TOKEN_KEY = "kSessionFCMToken"
//    private let kSESSION_WELCOME_DATA = "kSessionWelcomeData"
    private let kSESSION_LOGIN_USER_DATA = "kSessionUserData"

    
    //  MARK:- Save Device Token
    public var setDeviceTokenValue: String? {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: kSESSION_DEVICETOKEN_KEY);
                return;
            }
            UserDefaults.standard.set(newValue, forKey: kSESSION_DEVICETOKEN_KEY)
            UserDefaults.standard.synchronize()
        }
        get {
            if let string = UserDefaults.standard.value(forKey: kSESSION_DEVICETOKEN_KEY) as? String {
                return string
            }
            return nil
        }
    }
    
    public var setFCMTokenValue: String? {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: kSESSION_FCM_TOKEN_KEY);
                return;
            }
            UserDefaults.standard.set(newValue, forKey: kSESSION_FCM_TOKEN_KEY)
            UserDefaults.standard.synchronize()
        }
        get {
            if let string = UserDefaults.standard.value(forKey: kSESSION_FCM_TOKEN_KEY) as? String {
                return string
            }
            return nil
        }
    }
    
//    //  MARK:- Save user object
//    public var setWelcomeDataValue: WelcomeAPIModelData? {
//        set {
//            guard newValue != nil else {
//                UserDefaults.standard.removeObject(forKey: kSESSION_WELCOME_DATA);
//                return;
//            }
//            let encodedData = try? PropertyListEncoder().encode(newValue)
//            UserDefaults.standard.set(encodedData, forKey:kSESSION_WELCOME_DATA)
//            UserDefaults.standard.synchronize();
//        }
//        get {
//            if let data = UserDefaults.standard.value(forKey:kSESSION_WELCOME_DATA) as? Data {
//                return try? PropertyListDecoder().decode(WelcomeAPIModelData.self, from:data)
//            }
//            return nil
//        }
//    }
//    
    //  MARK:- Save user object
    public var setLoginUserDataValue: objLoginModelData? {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: kSESSION_LOGIN_USER_DATA);
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:kSESSION_LOGIN_USER_DATA)
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:kSESSION_LOGIN_USER_DATA) as? Data {
                return try? PropertyListDecoder().decode(objLoginModelData.self, from:data)
            }
            return nil
        }
    }
}

