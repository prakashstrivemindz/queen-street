
import Foundation
import UIKit
import SideMenuSwift

class Routing {
    
    class func setHomeAsInitialViewController() {
       
        DispatchQueue.main.async {
            
            if  let rootNavigationController = ( AppDelegate.sharedMainStoryBoard.instantiateViewController(withIdentifier: "RootNavigationController") as? UINavigationController ) {
                
                if  let tabBarController = ( AppDelegate.sharedMainStoryBoard.instantiateViewController(withIdentifier: "TabbarVC") as? TabbarVC ) {
                    
                    tabBarController.selectedIndex = 0

                    rootNavigationController.viewControllers = [tabBarController]
                    
                    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuVC")
                    let sideMenuController = SideMenuController(contentViewController: rootNavigationController, menuViewController: menuViewController)
                    
                    SideMenuController.preferences.basic.direction = .right

                    let window = UIApplication.shared.windows.first
                    window?.makeKeyAndVisible()
                    window?.rootViewController = sideMenuController
                    
                }
            }
        }
    }
   
}
