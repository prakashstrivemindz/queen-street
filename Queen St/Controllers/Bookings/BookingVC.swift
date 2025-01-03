//
//  BookingVC.swift
//  Queen St
//
//  Created by iMac on 18/12/24.
//

import UIKit
import SideMenuSwift

class BookingVC:BaseVC {
    
    //MARK: - OUTLETS

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    //MARK: - OBJECTS AND VARIABLES

    private var getBookingModel: GetBookingService = GetBookingService()
    private var cancelBookingModel: CancelBookingService = CancelBookingService()

    private var objBookingData : ObjGetBookingData = ObjGetBookingData()

    
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Initialize()
    }
    
    //MARK: - INITIALIZE METHOD

    func Initialize()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.ShowSideMenuButtonNotification(notification:)), name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)

        getBookingModel.GetBookingDelegate = self

        GetBookingAPI()
    }
    
    //MARK: - API CALLING
    
    func GetBookingAPI()
    {
        getBookingModel.GetBookingAPICall(Id: SessionManager.shared.setLoginUserDataValue?.userId ?? 0)
    }
    
    func CancelBookingAPI()
    {
        cancelBookingModel.CancelBookingAPICall(Id: objBookingData.id ?? "")
    }
    
    //MARK: - Button Action Method

    @IBAction func btnManage(_ sender: UIButton) {
   
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        CancelBookingAPI()
    }
    
    @IBAction func btnReservation(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSideMenu(_ sender: UIButton) {
        sideMenuController?.revealMenu()
        
        self.btnSideMenu.isHidden = true

    }
    
    @objc func ShowSideMenuButtonNotification(notification: Notification)
    {
        self.btnSideMenu.isHidden = false
    }
    
}

//MARK: - Get Data
extension BookingVC : GetBookingModelDelegate
{
    func GetBookingDataAPI(getBookingData: ObjGetBookingData) {
        
        print(getBookingData)
        
        self.objBookingData = getBookingData
        
        self.lblDateTime.text = "\(getBookingData.date ?? "")\n\(getBookingData.guestCount ?? "") guests - \(getBookingData.time ?? "")"
    }
   
}

extension BookingVC : CancelBookingModelDelegate
{
    func CancelBookingDataAPI() {
        
        
    }
    
}
