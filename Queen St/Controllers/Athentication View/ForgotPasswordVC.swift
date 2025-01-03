//
//  ForgotPasswordVC.swift
//  Queen St
//
//  Created by iMac on 20/12/24.
//

import UIKit

class ForgotPasswordVC: BaseVC {

    //MARK: - OBJECTS AND VARIABLES
    @IBOutlet weak var txtEmail: UITextField!
    
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - INITIALIZE METHOD

    
    //MARK: - Button Action Method

    @IBAction func btnSendPasswordReset(_ sender: UIButton) {
        
        if isValidate()
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    //MARK: - VALIDATION

    func isValidate() -> Bool
    {
        if (!isValidEmail(txtEmail.text!)) {
            txtEmail.becomeFirstResponder()
        }
        else{
            return true
        }
        return false
    }
}
