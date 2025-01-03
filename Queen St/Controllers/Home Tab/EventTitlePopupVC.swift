//
//  EventTitlePopupVC.swift
//  Queen St
//
//  Created by iMac on 23/12/24.
//

import UIKit

class EventTitlePopupVC: BaseVC {

    //MARK: - Outlets
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var topMarginViewMain: NSLayoutConstraint!
    @IBOutlet weak var bottomMarginViewMain: NSLayoutConstraint!
    @IBOutlet weak var imgEventTitle: UIImageView!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: - Object and variables

    
    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
    }
    
    //MARK: - Initialize Method
    func Initialize()
    {
        self.viewPopup.cornerRadius = 10
        self.viewPopup.borderColor = UIColor.init(hex: globalColor.tabbar_text_color)
        self.viewPopup.borderWidth = 1
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let topPadding = self.view.safeAreaInsets.top
            let bottomPadding = window?.safeAreaInsets.bottom
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.topMarginViewMain.constant = (self.view.safeAreaInsets.top) + 65
            self.bottomMarginViewMain.constant = (bottomPadding ?? 0) + (self.tabBarController?.getHeight() ?? 49)
        }else
        {
            self.topMarginViewMain.constant = (self.view.safeAreaInsets.top) + 65
            self.bottomMarginViewMain.constant = (bottomPadding ?? 0) + (self.tabBarController?.getHeight() ?? 45)
        }
    }
    
    
    //MARK: - Button Action

    @IBAction func btnReserveToday(_ sender: UIButton) {
        
    }
    
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    


}
