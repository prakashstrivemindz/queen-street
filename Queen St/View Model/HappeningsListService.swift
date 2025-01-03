//
//  HappeningsListService.swift
//  Queen St
//
//  Created by iMac on 02/01/25.
//

import Foundation

protocol HappeningsModelDelegate : AnyObject
{
    func HappeningsListDataAPI(happeningsData : [ObjHappeningsListData])
}

class HappeningsService : BaseVC
{
    weak var happeningsDelegate : HappeningsModelDelegate?

    func HappeningsAPICall() {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.happenings, type: [ObjHappeningsListData].self, isAccessToken: false, reqBodyData: nil) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.happeningsDelegate {
                            delegate.HappeningsListDataAPI(happeningsData: objData ?? [ObjHappeningsListData]())
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
