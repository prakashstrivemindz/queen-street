//
//  GetBookingService.swift
//  Queen St
//
//  Created by iMac on 03/01/25.
//

import Foundation

protocol GetBookingModelDelegate : AnyObject
{
    func GetBookingDataAPI(getBookingData : ObjGetBookingData)
}

class GetBookingService: BaseVC {
    
    weak var GetBookingDelegate: GetBookingModelDelegate?

    func GetBookingAPICall(Id : Int) {
        
        if reachability.connection != .none {
            
            self.createMainLoaderInView("Loading...")
            
            APIManager.sharedInstance.generateAPIRequest(reqEndpoint: APIConstants.getBooking(Id: Id), type: ObjGetBookingData.self, isAccessToken: false, reqBodyData: nil) { [weak self](status, objData, error) in
                
                self?.stopLoaderAnimation()
                
                if status {
                
                    if objData != nil
                    {
                        if let delegate = self?.GetBookingDelegate {
                            delegate.GetBookingDataAPI(getBookingData: objData!)
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
