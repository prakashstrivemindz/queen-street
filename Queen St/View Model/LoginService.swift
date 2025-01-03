//
//  LoginService.swift
//  Queen St
//
//  Created by iMac on 27/12/24.
//

import Foundation

protocol LoginViewModelDelegate : AnyObject
{
    func LoginDataAPI(loginUserData : objLoginModelData)
}

class LoginUserService: BaseVC {
    
    weak var LoginDelegate: LoginViewModelDelegate?

    func LoginAPICall(parameters : [String:Any]) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.signin, type: objLoginModelData.self, isAccessToken: false, reqBodyData: parameters) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.LoginDelegate {
                            delegate.LoginDataAPI(loginUserData: objData!)
                        }
                    }else
                    {
                        let _ = CustomAlertController.alert(title: APP.appName, message: error?.localizedDescription ?? APP.messageSomethingWrong)

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
