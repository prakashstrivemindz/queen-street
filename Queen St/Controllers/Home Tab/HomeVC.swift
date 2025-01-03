//
//  HomeVC.swift
//  Queen St
//
//  Created by iMac on 18/12/24.
//

import UIKit
import SideMenuSwift
import SDWebImage

class HomeVC: BaseVC {
      
    //MARK: - Outlets

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMemberStatus: UILabel!
    @IBOutlet weak var lblNextBooking: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var blQuests: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var clvVouchers: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var clvHappenings: UICollectionView!
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var heightViewHappenings: NSLayoutConstraint!
    
    //MARK: - Variables

    private var memberDetailsModel: MemberDetailsService = MemberDetailsService()

    var arrVouchers = [VoucherDetails]()
    var arrHappenings = [Happenings]()

    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Initizlize()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
                
        MemberDetailsAPI()

        if getBooleanValueFromUserDefaults_ForKey("openMembershipView") == true
        {
            setBooleanValueToUserDefaults(false, "openMembershipView")

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MembershipVC") as! MembershipVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        if getBooleanValueFromUserDefaults_ForKey("openHappeningsView") == true
        {
            setBooleanValueToUserDefaults(false, "openHappeningsView")

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HappeningsListVC") as! HappeningsListVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
        
    
    //MARK: - Initialize Method
    func Initizlize()
    {
        RegisterCell()
        
        memberDetailsModel.MemberDetailsDelegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(self.ShowSideMenuButtonNotification(notification:)), name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)

        // Open Announcement Popup
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnnouncementVC") as! AnnouncementVC
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openMembershipButtonNotification(notification:)), name: Notification.Name("openMembershipViewNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openHappeningsButtonNotification(notification:)), name: Notification.Name("openHappeningsViewNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logoutNotification(notification:)), name: Notification.Name("logoutNotification"), object: nil)

    }
    
    //MARK: - Register Cell
    func RegisterCell()
    {
        clvVouchers.register(UINib(nibName: "clvVoucherCell", bundle: nil), forCellWithReuseIdentifier: "clvVoucherCell")
        clvHappenings.register(UINib(nibName: "clvHappeningsCell", bundle: nil), forCellWithReuseIdentifier: "clvHappeningsCell")

    }
    
    //MARK: - API CALLING
    
    func MemberDetailsAPI()
    {
        let dict = ["userID": SessionManager.shared.setLoginUserDataValue?.userId ?? 0]
        
        memberDetailsModel.MemberDetailsAPICall(parameters: dict as [String : Any])
    }
    
    func PagerSetup()
    {
        // Setup Pager control
        self.pageControl.numberOfPages = self.arrVouchers.count
        self.pageControl.pageIndicatorTintColor = UIColor.init(hex: "575654")
        self.pageControl.currentPageIndicatorTintColor = UIColor.init(hex: globalColor.tabbar_text_color)
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    
    //MARK: - Button Action
    
    @IBAction func btnSideMenu(_ sender: UIButton) {

        sideMenuController?.revealMenu()
        
        self.btnSideMenu.isHidden = true

        
    }
  
    @IBAction func btnCardDetails(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailsVC") as! CardDetailsVC
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: false)
    }
    
    @IBAction func btnManage(_ sender: UIButton) {
   
    }
 
    
    @objc func logoutNotification(notification: Notification)
    {

        SessionManager.shared.setLoginUserDataValue = nil
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RootNavigationController") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func ShowSideMenuButtonNotification(notification: Notification)
    {
        self.btnSideMenu.isHidden = false
    }
    
    @objc func openMembershipButtonNotification(notification: Notification)
    {
        if getBooleanValueFromUserDefaults_ForKey("openMembershipView") == true
        {
            setBooleanValueToUserDefaults(false, "openMembershipView")

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MembershipVC") as! MembershipVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func openHappeningsButtonNotification(notification: Notification)
    {
        if getBooleanValueFromUserDefaults_ForKey("openHappeningsView") == true
        {
            setBooleanValueToUserDefaults(false, "openHappeningsView")

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HappeningsListVC") as! HappeningsListVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        
        let indexPath = IndexPath(item: gesture.view?.tag ?? 0, section: 0)
        let cell = clvVouchers.cellForItem(at: indexPath) as! clvVoucherCell
        
        if gesture.didTapAttributedTextInLabel(label: cell.lblDescription, targetText: "learn more") {
            print("learn more")

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VoucherVC") as! VoucherVC
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: false)
            
        } else {
            print("Tapped none")
        }
    }
    
    @objc func btnReserveAction(sender : UIButton)
    {
       
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == clvVouchers
        {
            let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
    }
    
    
}

//MARK: - Collectionview Method
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == clvVouchers
        {
            return arrVouchers.count
        }else
        {
            return arrHappenings.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == clvVouchers
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clvVoucherCell", for: indexPath) as! clvVoucherCell
            
            let dict = self.arrVouchers[indexPath.row]
            
            cell.viewMain.cornerRadius = 10
            cell.viewMain.borderColor = UIColor.init(hex: globalColor.tabbar_text_color)
            cell.viewMain.borderWidth = 1
            
            cell.lblVouchers.text = "£\(dict.price ?? "") Voucher"
            
            // Setup label clickable
            cell.lblDescription.text = "\(dict.description ?? "") learn more"
            let text = (cell.lblDescription.text)!
            let underlineAttriString = NSMutableAttributedString(string: text)
            let learnMoreRange = (text as NSString).range(of: "learn more")
            underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: learnMoreRange)
            underlineAttriString.addAttribute(.foregroundColor, value: UIColor.black, range: learnMoreRange)
            cell.lblDescription.attributedText = underlineAttriString
            let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
            cell.lblDescription.isUserInteractionEnabled = true
            cell.lblDescription.tag = indexPath.row
            cell.lblDescription.addGestureRecognizer(tapAction)
            
            return cell
        }else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clvHappeningsCell", for: indexPath) as! clvHappeningsCell

            cell.btnReserve.tag = indexPath.row
            cell.btnReserve.addTarget(self, action: #selector(btnReserveAction), for: .touchUpInside)
            
            let dict = arrHappenings[indexPath.row]
            
            cell.lblEventTitle.text = dict.title ?? ""
            
            cell.imgHappenings.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage: UIImage(named: "img_profile_placeholder"), options: SDWebImageOptions.refreshCached, completed: { image, error, cacheType, imageURL in
                
            })
            
            cell.lblDescription.text = dict.description ?? ""
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == clvVouchers
        {
            
        }else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HappeningsListVC") as! HappeningsListVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == clvVouchers
        {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }else
        {
            if UIDevice.current.userInterfaceIdiom == .phone {
                
                return CGSize(width: collectionView.frame.size.width/1.3, height: collectionView.frame.size.height)
            }else
            {
                
                return CGSize(width: collectionView.frame.size.width/1.95, height: collectionView.frame.size.height)
            }
         
        }
    }
 
}

//MARK: - Get Data

extension HomeVC : MemberDetailsModelDelegate
{
    func MemberDetailsAPI(memberDetailsData: ObjMemberDetailsData) {
        
        print(memberDetailsData)
        
        let currentTime = Date()
        self.lblTitle.text = "\(currentTime.timeLabel), \(memberDetailsData.name ?? "")"
        self.lblMemberStatus.text = memberDetailsData.membershipType ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: memberDetailsData.nextBoooking?.date ?? "")
        
        self.lblDate.text = date?.formattedWithOrdinal()
        self.blQuests.text = "\(memberDetailsData.nextBoooking?.guestCount ?? "") Guests"
        self.lblTime.text = memberDetailsData.nextBoooking?.time ?? ""
        
        self.arrVouchers = memberDetailsData.voucherDetails ?? [VoucherDetails]()
        self.arrHappenings = memberDetailsData.happenings ?? [Happenings]()
        
        PagerSetup()

        
        self.clvVouchers.reloadData()
        self.clvHappenings.reloadData()
    }
    
}
