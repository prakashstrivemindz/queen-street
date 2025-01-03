//
//  ProfileVC.swift
//  Queen St
//
//  Created by iMac on 18/12/24.
//

import UIKit
import SideMenuSwift
import DropDown

fileprivate enum DropDownType {
    case maritalStatus
}

class ProfileVC: BaseVC {
    
    //MARK: - OBJECTS AND VARIABLES
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var viewMaritalStatus: UIView!
    @IBOutlet weak var txtMaritalStatus: UITextField!
    @IBOutlet weak var txtfirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtInstagram: UITextField!
    @IBOutlet weak var txtLinkedin: UITextField!
    @IBOutlet weak var txtCompanyWebsite: UITextField!
    @IBOutlet weak var txtCompanyPosition: UITextField!
    @IBOutlet weak var txtRecommendedBy: UITextField!
    
    //MARK: - Variables and Objects
    
    fileprivate var selectedDropDown : DropDownType?
    var dropDown = DropDown()
    
    var arrDropDown = ["Mr.","Mrs.","Ms.","Miss"]
    let datePickerView : UIDatePicker = UIDatePicker()
    
    private var getProfileModel: GetProfileService = GetProfileService()
    private var updateProfileModel: UpdateProfileService = UpdateProfileService()

    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetProfileAPI()
    }
    
    //MARK: - INITIALIZE METHOD
    
    func Initialize()
    {
        getProfileModel.GetProfileDelegate = self
        updateProfileModel.UpdateProfileDelegate = self

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.ShowSideMenuButtonNotification(notification:)), name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)
        
        
        ShowDropDown()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        txtDOB.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
        
    }
    
    //MARK: - API CALLING
    
    func GetProfileAPI()
    {
        let dict = ["id": SessionManager.shared.setLoginUserDataValue?.userId ?? 0]
        
        getProfileModel.GetProfileAPICall(parameters: dict as [String : Any])
    }
    
    func UpdateProfileAPI()
    {
        let dict = ["title" : self.txtMaritalStatus.text ?? "",
                    "firstName" : self.txtfirstName.text ?? "",
                    "lastName" : self.txtLastName.text ?? "",
                    "email" : self.txtEmail.text ?? "",
                    "mobile" : self.txtMobile.text ?? "",
                    "dateOfBirth" : self.txtDOB.text ?? "",
                    "instagram" : self.txtInstagram.text ?? "",
                    "linkedIn" : self.txtLinkedin.text ?? "",
                    "comapnyWebsite" : self.txtCompanyWebsite.text ?? "",
                    "companyPosition" : self.txtCompanyPosition.text ?? "",
                    "recommendedBy" : self.txtRecommendedBy.text ?? "",
                    "id" : SessionManager.shared.setLoginUserDataValue?.userId ?? 0]  as [String : Any]
        
        updateProfileModel.UpdateProfileAPICall(parameters: dict as [String : Any])
    }
    
    //MARK: - Button Action Method
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
//        dateFormatter.dateStyle = DateFormatter.Style.medium
        //        dateFormatter.timeStyle = DateFormatter.Style.none
        txtDOB.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        
        if isValidate()
        {
            UpdateProfileAPI()
        }
    }
    
    
    @IBAction func btnSideMenu(_ sender: UIButton) {
        
        sideMenuController?.revealMenu()
        
        self.btnSideMenu.isHidden = true
        
    }
    
    @IBAction func btnMaritalStatusDropDown(_ sender: UIButton) {
        selectedDropDown = DropDownType.maritalStatus
        dropDown.width = viewMaritalStatus.frame.width
        dropDown.anchorView = viewMaritalStatus
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = arrDropDown
        dropDown.show()
    }
    
    @IBAction func btnDateOfBirth(_ sender: UIButton) {
        
    }
    
    
    @objc func ShowSideMenuButtonNotification(notification: Notification)
    {
        self.btnSideMenu.isHidden = false
    }
    
    //MARK: - Other function
    func ShowDropDown()
    {
        dropDown.backgroundColor = UIColor.black
        dropDown.selectionBackgroundColor = UIColor.darkGray
        dropDown.layer.cornerRadius = 10.0
        dropDown.clipsToBounds = true
        dropDown.textColor = UIColor.init(hex: globalColor.tabbar_text_color)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if self.selectedDropDown == DropDownType.maritalStatus {
                self.txtMaritalStatus.text = item
            }
        }
    }
    
    //MARK: - VALIDATION
    
    func isValidate() -> Bool
    {
        if txtMaritalStatus.text == "" || txtMaritalStatus.text!.isEmptyOrWhitespace()
        {
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter marital status")
        }else if txtfirstName.text == "" || txtfirstName.text!.isEmptyOrWhitespace()
        {
            txtfirstName.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter first name")
        }else if txtLastName.text == "" || txtLastName.text!.isEmptyOrWhitespace()
        {
            txtLastName.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter last name")
        }
//        else if (!isValidEmail(txtEmail.text!)) {
//            txtEmail.becomeFirstResponder()
//        }
        else if txtMaritalStatus.text == "" || txtMaritalStatus.text!.isEmptyOrWhitespace()
        {
            txtMaritalStatus.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter mobile")
        }else if txtMobile.text!.count < 10
        {
            txtMobile.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter valid mobile")
            
        }else if txtDOB.text == "" || txtDOB.text!.isEmptyOrWhitespace()
        {
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter DOB")
        }else if txtInstagram.text == "" || txtInstagram.text!.isEmptyOrWhitespace()
        {
            txtInstagram.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter instagram")
        }else if txtLinkedin.text == "" || txtLinkedin.text!.isEmptyOrWhitespace()
        {
            txtLinkedin.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter LinkedIn")
        }else if txtCompanyWebsite.text == "" || txtCompanyWebsite.text!.isEmptyOrWhitespace()
        {
            txtCompanyWebsite.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter company website")
        }else if txtCompanyPosition.text == "" || txtCompanyPosition.text!.isEmptyOrWhitespace()
        {
            txtCompanyPosition.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter position with company")
        }else if txtRecommendedBy.text == "" || txtRecommendedBy.text!.isEmptyOrWhitespace()
        {
            txtRecommendedBy.becomeFirstResponder()
            let _ = CustomAlertController.alert(title: APP.appName, message: "Please enter recommended by")
        }
        else{
            return true
        }
        return false
    }
}

//MARK: - Get Data
extension ProfileVC : GetProfileModelDelegate
{
    func GetProfileDataAPI(getProfileData: ObjProfileData) {
        
        print(getProfileData)
        
        self.txtMaritalStatus.text = getProfileData.title ?? ""
        self.txtfirstName.text = getProfileData.firstName ?? ""
        self.txtLastName.text = getProfileData.lastName ?? ""
        self.txtEmail.text = getProfileData.email ?? ""
        self.txtMobile.text = getProfileData.mobile ?? ""
        self.txtDOB.text = getProfileData.dateOfBirth ?? ""
        self.txtInstagram.text = getProfileData.instagram ?? ""
        self.txtLinkedin.text = getProfileData.linkedIn ?? ""
        self.txtCompanyWebsite.text = getProfileData.comapnyWebsite ?? ""
        self.txtCompanyPosition.text = getProfileData.companyPosition ?? ""
        self.txtRecommendedBy.text = getProfileData.recommendedBy ?? ""
    }
    
}

extension ProfileVC : UpdateProfileModelDelegate
{
    func UpdateProfileDataAPI(updateProfileData: ObjMessage) {
        
        let _ = CustomAlertController.alert(title: APP.appName, message: updateProfileData.message ?? "")

    }
    
}
