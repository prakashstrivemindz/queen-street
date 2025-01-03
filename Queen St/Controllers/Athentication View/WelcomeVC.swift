//
//  WelcomeVC.swift
//  Queen St
//
//  Created by iMac on 20/12/24.
//

import UIKit
import SideMenuSwift

class WelcomeVC: BaseVC {

    //MARK: - OBJECTS AND VARIABLES
    
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - INITIALIZE METHOD

    
    //MARK: - Button Action Method
    @IBAction func btnLogin(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "webviewVC") as! webviewVC
        vc.strURL = webViewURLs.register
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
}
