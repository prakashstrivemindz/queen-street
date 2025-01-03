//
//  ViewController.swift
//  Queen St
//
//  Created by iMac on 15/11/24.
//

import UIKit
import SideMenuSwift

class SplashVC: BaseVC {

    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Initialize()
    }

    
    //MARK: - INITIALIZE METHOD
    func Initialize()
    {
        if SessionManager.shared.setLoginUserDataValue != nil
        {
            Routing.setHomeAsInitialViewController()

        }else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
      
        
    }
}

