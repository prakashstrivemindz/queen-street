//
//  LogoutService.swift
//  Queen St
//
//  Created by iMac on 03/01/25.
//

import Foundation

protocol LogoutModelDelegate : AnyObject
{
    func LogoutAPI()
}

class LogoutUserService: BaseVC {
    
    weak var LogoutDelegate: LogoutModelDelegate?

    func LogoutAPICall(parameters : [String:Any]) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.logout, type: ObjMessage.self, isAccessToken: false, reqBodyData: parameters) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if let delegate = self?.LogoutDelegate {
                        delegate.LogoutAPI()
                    }
                    
                } else {
                    print("Status else - \(status)")
                    let _ = CustomAlertController.alert(title: APP.appName, message: error?.localizedDescription ?? APP.messageSomethingWrong)
                }
            }
            
        } else {
            showNoInternetAlert()
        }
        
    }
}
