//
//  MembershipDetailsService.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

protocol MembershipModelDelegate : AnyObject
{
    func MembershipDataAPI(membershipData : ObjMembershipDetailsData)
}

class MembershipService : BaseVC
{
    weak var MembershipDelegate : MembershipModelDelegate?

    func MembershipDetailsAPICall(parameters : [String:Any]) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.membershipDetails, type: ObjMembershipDetailsData.self, isAccessToken: false, reqBodyData: parameters) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.MembershipDelegate {
                            delegate.MembershipDataAPI(membershipData: objData ?? ObjMembershipDetailsData())
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
