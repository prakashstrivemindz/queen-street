//
//  ResetPasswordVC.swift
//  Queen St
//
//  Created by iMac on 20/12/24.
//

import UIKit

class ResetPasswordVC: BaseVC {

    //MARK: - OBJECTS AND VARIABLES
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtRetypePassword: UITextField!
    
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - INITIALIZE METHOD

    
    //MARK: - Button Action Method
    @IBAction func btnSubmit(_ sender: UIButton) {
        
        if isValidate()
        {
            self.navigationController?.popToViewController(ofClass: LoginVC.self)
        }
        
    }
    
    //MARK: - VALIDATION

    func isValidate() -> Bool
    {
        if txtNewPassword.text == "" || txtNewPassword.text!.isEmptyOrWhitespace()
        {
            txtNewPassword.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter new password")
        }else if self.txtNewPassword.text!.length < 8
        {
            txtNewPassword.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "New password should be more than 8 digits")
        }else if txtRetypePassword.text == "" || txtRetypePassword.text!.isEmptyOrWhitespace()
        {
            txtRetypePassword.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter retype password")
        }else if self.txtNewPassword.text != txtRetypePassword.text
        {
            txtRetypePassword.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "New password and retype password should be same")
        }
        else{
            return true
        }
        return false
    }
}
