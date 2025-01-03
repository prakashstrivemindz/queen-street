//
//  MembershipVC.swift
//  Queen St
//
//  Created by iMac on 23/12/24.
//

import UIKit
import SDWebImage

class MembershipVC: BaseVC {

    
    //MARK: - Outlets
    @IBOutlet weak var viewImgProfile: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnMembershipTier: UIButton!
    @IBOutlet weak var lblMember: UILabel!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var lblCardName: UILabel!
    @IBOutlet weak var lblCardMember: UILabel!
    @IBOutlet weak var imgQrCode: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblRenewalDate: UILabel!
    @IBOutlet weak var lblCardDetails: UILabel!
    @IBOutlet weak var lblYearly: UILabel!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    
    //MARK: - Object and variables
    
    
    private var membershipModel: MembershipService = MembershipService()

    

    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        MembershipAPI()
        
    }
    
    //MARK: - Initialize Method
    func Initialize()
    {
        membershipModel.MembershipDelegate = self

        self.viewCard.cornerRadius = 16.0

        NotificationCenter.default.addObserver(self, selector: #selector(self.ShowSideMenuButtonNotification(notification:)), name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)

     
    }
    
    //MARK: - API CALLING
    
    func MembershipAPI()
    {
        let dict = ["user_id": SessionManager.shared.setLoginUserDataValue?.userId ?? 0]
        
        membershipModel.MembershipDetailsAPICall(parameters: dict as [String : Any])
    }
    
    //MARK: - Button Action

    @IBAction func btnSideMenu(_ sender: UIButton) {
      
        sideMenuController?.revealMenu()
        
        self.btnSideMenu.isHidden = true

    }
    
    @objc func ShowSideMenuButtonNotification(notification: Notification)
    {
        self.btnSideMenu.isHidden = false
    }
    
    
    @IBAction func btnRenewalDate(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func btnTC(_ sender: Any) {
    }
    
    @IBAction func btnCardDetails(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnSubscription(_ sender: UIButton) {
   
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        
    }
   
}

//MARK: - Get Data

extension MembershipVC : MembershipModelDelegate
{
    func MembershipDataAPI(membershipData: ObjMembershipDetailsData) {
        
        print(membershipData)
        
        self.imgProfile.sd_setImage(with: URL(string: membershipData.image ?? ""), placeholderImage: UIImage(named: "img_profile_placeholder"), options: SDWebImageOptions.refreshCached, completed: { image, error, cacheType, imageURL in
            
        })
        
        self.lblName.text = membershipData.name ?? ""
        self.lblMember.text = ""
        
        self.lblCardName.text = membershipData.cardDetails?.name ?? ""
        self.lblCardMember.text = "\(membershipData.cardDetails?.member ?? 0)"
        self.lblNumber.text = membershipData.cardDetails?.number ?? ""
        
        self.lblRenewalDate.text = membershipData.subscription?.expiredDate ?? ""
        self.lblCardDetails.text = membershipData.cardDetails?.number ?? ""
        self.lblYearly.text = membershipData.subscription?.plan ?? ""
        
    }
    
}
