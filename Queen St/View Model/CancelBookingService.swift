//
//  CancelBookingService.swift
//  Queen St
//
//  Created by iMac on 03/01/25.
//

import Foundation

protocol CancelBookingModelDelegate : AnyObject
{
    func CancelBookingDataAPI()
}

class CancelBookingService: BaseVC {
    
    weak var CancelBookingDelegate: CancelBookingModelDelegate?

    func CancelBookingAPICall(Id : String) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.cancelBooking(Id: Id), type: ObjMessage.self, isAccessToken: false, reqBodyData: nil) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.CancelBookingDelegate {
                            delegate.CancelBookingDataAPI()
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
