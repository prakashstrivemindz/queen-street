//
//  MemberDetailsService.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

protocol MemberDetailsModelDelegate : AnyObject
{
    func MemberDetailsAPI(memberDetailsData : ObjMemberDetailsData)
}

class MemberDetailsService: BaseVC {
    
    weak var MemberDetailsDelegate: MemberDetailsModelDelegate?

    func MemberDetailsAPICall(parameters : [String:Any]) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.memberDetails, type: ObjMemberDetailsData.self, isAccessToken: false, reqBodyData: parameters) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.MemberDetailsDelegate {
                            delegate.MemberDetailsAPI(memberDetailsData: objData ?? ObjMemberDetailsData())
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
