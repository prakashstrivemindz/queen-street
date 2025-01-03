//
//  GetProfileService.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

protocol GetProfileModelDelegate : AnyObject
{
    func  GetProfileDataAPI(getProfileData : ObjProfileData)
}

class  GetProfileService: BaseVC {
    
    weak var GetProfileDelegate:  GetProfileModelDelegate?

    func GetProfileAPICall(parameters : [String:Any]) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.profile, type: ObjProfileData.self, isAccessToken: false, reqBodyData: parameters) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.GetProfileDelegate {
                            delegate.GetProfileDataAPI(getProfileData: objData!)
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
