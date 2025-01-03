//
//  ObjUpdateProfile.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

struct ObjMessage: Codable {
    
    var status: Int?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
}
