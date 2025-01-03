//
//  objLoginModel.swift
//  Queen St
//
//  Created by iMac on 27/12/24.
//

import Foundation

struct objLoginModel: Codable {
    
    var status: Int?
    var message: String?
    var data: objLoginModelData?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

struct objLoginModelData: Codable {
    
    var token: String?
    var userId: Int?
    var name: String?
    var email: String?
    var roles: [String]?
    var FCMUserToken: String?
    var deviceId: String?
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case userId = "userId"
        case name = "name"
        case email = "email"
        case roles = "roles"
        case FCMUserToken = "FCMUserToken"
        case deviceId = "deviceId"
    }
    
}
