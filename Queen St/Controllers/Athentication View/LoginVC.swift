//
//  LoginVC.swift
//  Queen St
//
//  Created by iMac on 20/12/24.
//

import UIKit
import SideMenuSwift

class LoginVC: BaseVC {

    //MARK: - OUTLETS

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - OBJECTS AND VARIABLES

    private var loginViewModel: LoginUserService = LoginUserService()
    private var objLoginUser : objLoginModelData = objLoginModelData()
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
    }
    
    //MARK: - INITIALIZE METHOD

    func Initialize()
    {
        loginViewModel.LoginDelegate = self

    }
    
    
    //MARK: - API CALLING
    
    func LoginUserAPI()
    {
        let dict = ["email": self.txtEmail.text ?? "",
                    "password": "123",
                    "FCMUserToken" : "",
                    "deviceId" : globalObject.DeviceUUID]
        
        loginViewModel.LoginAPICall(parameters: dict as [String : Any])
    }
    
    //MARK: - Button Action Method

    @IBAction func btnForgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if isValidate()
        {
            self.LoginUserAPI()
          
        }
        
    }
    
    
    //MARK: - VALIDATION

    func isValidate() -> Bool
    {
        if (!isValidEmail(txtEmail.text!)) {
            txtEmail.becomeFirstResponder()
        }else if self.txtPassword.text == "" || txtPassword.text!.isEmptyOrWhitespace()
        {
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter password")
            txtPassword.becomeFirstResponder()

        }else if self.txtPassword.text!.length < 8
        {
            let _ = CustomAlertController.alert(title: APP.appName, message: "Password should be more than 8 digits")
            txtPassword.becomeFirstResponder()

        }
        else{
            return true
        }
        return false
    }
    
}

//MARK: - Get Data
extension LoginVC : LoginViewModelDelegate
{
    func LoginDataAPI(loginUserData: objLoginModelData) {
        
        print("Login User Data : \(loginUserData)")

        objLoginUser = loginUserData
        
        SessionManager.shared.setLoginUserDataValue = objLoginUser
                         
        Routing.setHomeAsInitialViewController()
        
    }
  
}
