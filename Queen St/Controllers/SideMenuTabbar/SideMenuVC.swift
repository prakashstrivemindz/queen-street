
import UIKit
import SideMenuSwift

class SideMenuVC: BaseVC {

    //MARK: - Outlets

    @IBOutlet weak var tblSideMenu: UITableView!
    @IBOutlet weak var sideMenuTrailing: NSLayoutConstraint!
    @IBOutlet weak var trailingHeaderView: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var bottomMarginViewMain: NSLayoutConstraint!
    
    //MARK: - OBJECTS AND VARIABLES

    var arrSideBar = ["Home","Happenings","Membership","My Bookings","Profile","Contact","Logout"]
    
    private var logoutModel: LogoutUserService = LogoutUserService()

    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
        
    }

    func Initialize()
    {
        logoutModel.LogoutDelegate = self

        self.tblSideMenu.register(UINib(nibName: "SideMenuVCCell", bundle: nil), forCellReuseIdentifier: "SideMenuVCCell")
        
        configureView()

        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let topPadding = self.view.safeAreaInsets.top
            let bottomPadding = window?.safeAreaInsets.bottom
        
        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.bottomMarginViewMain.constant = (bottomPadding ?? 0) + (self.tabBarController?.getHeight() ?? 49)
        }else
        {
            self.bottomMarginViewMain.constant = (bottomPadding ?? 0) + (self.tabBarController?.getHeight() ?? 25)
        }
    }
    
    
    //MARK: - API CALLING
    
    func LogoutUserAPI()
    {
        let dict = ["id": SessionManager.shared.setLoginUserDataValue?.userId ?? 0]
        
        logoutModel.LogoutAPICall(parameters: dict as [String : Any])
    }
    
 
    //MARK: - Button Action Method

    @IBAction func btnCloseSideMenu(_ sender: UIButton) {
        
        sideMenuController?.hideMenu()

        NotificationCenter.default.post(name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)

    }
    
    //MARK: - Other Function

    private func configureView() {
        
        sideMenuController?.delegate = self
        
        trailingHeaderView.constant = UIScreen.main.bounds.width/2
        sideMenuTrailing.constant = UIScreen.main.bounds.width/2
        
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width/2
        //SideMenuController.preferences.basic.statusBarBehavior = .none
//        SideMenuController.preferences.basic.position = .sideBySide
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
//        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        SideMenuController.preferences.basic.direction = .right

    }
}

//MARK: - Tableview Delagte and Data source methods

extension SideMenuVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return arrSideBar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuVCCell", for: indexPath) as! SideMenuVCCell
        
        cell.lblViewName.text = arrSideBar[indexPath.row]
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
        sideMenuController?.hideMenu()
        
        NotificationCenter.default.post(name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)
        setBooleanValueToUserDefaults(false, "openMembershipView")
        setBooleanValueToUserDefaults(false, "openHappeningsView")
        setBooleanValueToUserDefaults(false, "openHomeView")

        if indexPath.row == 0
        {
            Routing.setHomeAsInitialViewController()
            
        }else if indexPath.row == 1
        {
            setBooleanValueToUserDefaults(true, "openHappeningsView")
            
            NotificationCenter.default.post(name: Notification.Name("openHappeningsViewNotification"), object: nil)

            (rootNavigationController.viewControllers.first as! UITabBarController).selectedIndex = 0
            

        }else if indexPath.row == 2
        {
            setBooleanValueToUserDefaults(true, "openMembershipView")
            
            NotificationCenter.default.post(name: Notification.Name("openMembershipViewNotification"), object: nil)

            (rootNavigationController.viewControllers.first as! UITabBarController).selectedIndex = 0

            
        }else if indexPath.row == 3
        {
            (rootNavigationController.viewControllers.first as! UITabBarController).selectedIndex = 2

        }else if indexPath.row == 4
        {
            (rootNavigationController.viewControllers.first as! UITabBarController).selectedIndex = 1

        }else if indexPath.row == 5
        {
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
            
        }else if indexPath.row == 6
        {
            
            let alertController = UIAlertController(title: APP.appName, message: "Are you sure you want to logout from your account?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Logout", style: .default) { (action:UIAlertAction) in
                
                if SessionManager.shared.setLoginUserDataValue != nil {
                    
                    self.sideMenuController?.hideMenu()
                    
                    (self.rootNavigationController.viewControllers.first as! UITabBarController).selectedIndex = 0
                    
                    self.LogoutUserAPI()
                    
                }
                
            }
            action1.setValue(UIColor.init(hex: "E41D58"), forKey: "titleTextColor")
            
            
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                
                
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
}

//MARK: - Side menu delegate method
extension SideMenuVC: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromRight, duration: 0.6)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        //print("[Example] View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        //print("[Example] View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        //print("[Example] Menu will hide")
        
        NotificationCenter.default.post(name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)

    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        //print("[Example] Menu did hide.")
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        //print("[Example] Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        //print("[Example] Menu did reveal.")
    }
}

//MARK: - Get Data
extension SideMenuVC : LogoutModelDelegate
{
    func LogoutAPI() {
        
        NotificationCenter.default.post(name: Notification.Name("logoutNotification"), object: nil)

    }
}
