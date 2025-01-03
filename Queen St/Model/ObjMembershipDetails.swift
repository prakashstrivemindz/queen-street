//
//  ObjMembershipDetails.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

struct ObjMembershipDetails: Codable {
    var status: Int?
    var message: String?
    var data: ObjMembershipDetailsData?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

struct ObjMembershipDetailsData: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var date: String?
    var cardDetails: ObjMembershipCardDetails?
    var subscription: ObjMembershipCardSubscription?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case date = "date"
        case cardDetails = "cardDetails"
        case subscription = "subscription"
    }
}

struct ObjMembershipCardDetails: Codable {
    var id: String?
    var name: String?
    var member: Int?
    var number: String?
    var cardFile: String?
    var qrCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case member = "member"
        case number = "number"
        case cardFile = "cardFile"
        case qrCode = "qrCode"
    }
}

struct ObjMembershipCardSubscription: Codable {
    var id: Int?
    var plan: String?
    var price: String?
    var subscriptionDate: String?
    var expiredDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case plan = "plan"
        case price = "price"
        case subscriptionDate = "subscriptionDate"
        case expiredDate = "expiredDate"
    }
}
