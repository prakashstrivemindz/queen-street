//
//  BaseVC.swift
//  Queen St
//
//  Created by iMac on 15/11/24.
//

import UIKit
import NVActivityIndicatorView

class BaseVC: UIViewController, UIGestureRecognizerDelegate, NVActivityIndicatorViewable{
    
    //MARK: - OBJECTS AND VARIABLES
    var reachability: Reachability = Reachability()!

    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print("Token: \(SessionManager.shared.setLoginUserDataValue?.token ?? "")")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    
    }
    
    //  MARK: - Loader Methods
    func createMainLoaderInView(_ message : String) {
        runOnMainThread {
            let size = CGSize(width: 40, height: 40)
            self.startAnimating(size, message: message, type: .ballSpinFadeLoader)//ballClipRotatePulse
        }
    }
    
    func stopLoaderAnimation() {
        runOnMainThread {
            self.stopAnimating()
        }
    }

}
