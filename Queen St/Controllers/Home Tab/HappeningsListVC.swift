//
//  HappeningsListVC.swift
//  Queen St
//
//  Created by iMac on 23/12/24.
//

import UIKit
import SDWebImage

class HappeningsListVC: BaseVC {

    //MARK: - Outlets
    @IBOutlet weak var tblHappeningsList: UITableView!
    @IBOutlet weak var heightTblList: NSLayoutConstraint!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    
    //MARK: - Object and variables
    private var happeningsListModel: HappeningsService = HappeningsService()

    var arrHappeningsList = [ObjHappeningsListData]()
    
    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    //MARK: - Initialize Method
    func Initialize()
    {
        RegisterCell()
        
        happeningsListModel.happeningsDelegate = self

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.ShowSideMenuButtonNotification(notification:)), name: Notification.Name("ShowSideMenuButtonNotification"), object: nil)

        HappeningsListAPI()
    }
    
    
    //MARK: - Register Cell

    func RegisterCell()
    {
        tblHappeningsList.register(UINib(nibName: "tblHappeningsListCell", bundle: .main), forCellReuseIdentifier: "tblHappeningsListCell")

    }
    
    //MARK: - API CALLING
    
    func HappeningsListAPI()
    {
        
        happeningsListModel.HappeningsAPICall()
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
    
    @objc func btnReserveAction(_ sender: UIButton)
    {
       
    }
    
    @objc func btnLearnMoreAction(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventTitlePopupVC") as! EventTitlePopupVC
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: false)
    }
   
}

//MARK: - Tableview Method
extension HappeningsListVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHappeningsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblHappeningsListCell", for: indexPath) as! tblHappeningsListCell
        
        cell.btnReserve.tag = indexPath.row
        cell.btnReserve.addTarget(self, action: #selector(btnReserveAction), for: .touchUpInside)
        
        cell.btnLearnMore.tag = indexPath.row
        cell.btnLearnMore.addTarget(self, action: #selector(btnLearnMoreAction), for: .touchUpInside)
        
        let dict = arrHappeningsList[indexPath.row]
        
        cell.lblEventTitle.text = dict.title ?? ""
        
        cell.imgHappenings.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage: UIImage(named: "img_profile_placeholder"), options: SDWebImageOptions.refreshCached, completed: { image, error, cacheType, imageURL in
            
        })
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dict.date ?? "")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        cell.lblDate.text = "Date: \(dateFormatter.string(from: date ?? Date()))"
        
        cell.lblDescription.text = dict.description ?? ""
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        runOnMainThread {
            self.heightTblList.constant = self.tblHappeningsList.contentSize.height
            self.tblHappeningsList.layoutIfNeeded()
        }
    }
}

//MARK: - Get Data
extension HappeningsListVC : HappeningsModelDelegate
{
    func HappeningsListDataAPI(happeningsData: [ObjHappeningsListData]) {
        
        print(happeningsData)
        
        self.arrHappeningsList = happeningsData
        
        self.tblHappeningsList.reloadData()
    }
    
}
