//
//  TabbarVC.swift
//  Queen St
//
//  Created by iMac on 18/12/24.
//

import UIKit

class TabbarVC: UITabBarController {

    //MARK: - OBJECTS AND VARIABLES
    
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
    }
    
    //MARK: - INITIALIZE METHOD
    func Initialize()
    {
        self.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Regular", size: 11)!], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Regular", size: 11)!], for: .selected)
        }else
        {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Regular", size: 15)!], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Regular", size: 15)!], for: .selected)
        }

        UITabBar.appearance().tintColor = UIColor.init(hex: globalColor.tabbar_text_color)
        UITabBar.appearance().unselectedItemTintColor = UIColor.init(hex: globalColor.tabbar_text_color)
        
        self.tabBar.addBorder(.top, color: UIColor.init(hex: globalColor.tabbar_text_color), thickness: 1)

    }
    
    
}

// MARK: - Tabbar Delegate Method
extension TabbarVC : UITabBarControllerDelegate
{
   
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        setIntegerValueToUserDefaults(tabBarController.selectedIndex, "selectedTabbarIndex")
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex == 3
        {
            print(getIntegerValueFromUserDefaults_ForKey("selectedTabbarIndex"))
            
            tabBarController.selectedIndex = getIntegerValueFromUserDefaults_ForKey("selectedTabbarIndex")
            
            let phoneNumber =  "+981234567890" // you need to change this number
            let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(appURL)
                }
            }
        }
    }
}
