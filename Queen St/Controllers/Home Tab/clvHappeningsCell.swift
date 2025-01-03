//
//  clvHappeningsCell.swift
//  Queen St
//
//  Created by iMac on 19/12/24.
//

import UIKit

class clvHappeningsCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgHappenings: UIImageView!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnReserve: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
