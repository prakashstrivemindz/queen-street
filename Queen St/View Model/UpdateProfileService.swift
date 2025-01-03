//
//  UpdateProfileService.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

protocol UpdateProfileModelDelegate : AnyObject
{
    func  UpdateProfileDataAPI(updateProfileData : ObjMessage)
}

class  UpdateProfileService: BaseVC {
    
    weak var UpdateProfileDelegate: UpdateProfileModelDelegate?

    func UpdateProfileAPICall(parameters : [String:Any]) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.updateProfile, type: ObjMessage.self, isAccessToken: false, reqBodyData: parameters) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if let delegate = self?.UpdateProfileDelegate {
                        delegate.UpdateProfileDataAPI(updateProfileData: objData!)
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
