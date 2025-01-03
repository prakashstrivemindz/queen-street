//
//  BookingVC.swift
//  Queen St
//
//  Created by iMac on 18/12/24.
//

import UIKit
import SideMenuSwift

class BookingVC:BaseVC {
    
    //MARK: - OBJECTS AND VARIABLES
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    
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

    }
    
    
    //MARK: - Button Action Method

    @IBAction func btnManage(_ sender: UIButton) {
   
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        
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
