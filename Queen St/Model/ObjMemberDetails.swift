//
//  ObjMemberDetails.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

struct ObjMemberDetails: Codable {
    
    var status: Int?
    var message: String?
    var data: ObjMemberDetailsData?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

struct ObjMemberDetailsData: Codable {
    
    var id: Int?
    var name: String?
    var memberStatus: String?
    var membershipType: String?
    var anouncement: Anouncement?
    var cardDetails: CardDetails?
    var nextBoooking: NextBoooking?
    var voucherDetails: [VoucherDetails]?
    var happenings: [Happenings]?
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case memberStatus = "memberStatus"
        case membershipType = "membershipType"
        case anouncement = "anouncement"
        case cardDetails = "cardDetails"
        case nextBoooking = "nextBoooking"
        case voucherDetails = "voucherDetails"
        case happenings = "happenings"
    }
}

struct Anouncement: Codable {
    
    var id: String?
    var subTitle: String?
    var expiredDate: String?
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case subTitle = "subTitle"
        case expiredDate = "expiredDate"
        case description = "description"
    }
}

struct CardDetails: Codable {
    
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

struct NextBoooking: Codable {
    
    var id: String?
    var date: String?
    var time: String?
    var guestCount: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case time = "time"
        case guestCount = "guestCount"
    }
}

struct VoucherDetails: Codable {
    
    var id: String?
    var price: String?
    var expiredDate: String?
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case price = "price"
        case expiredDate = "expiredDate"
        case description = "description"
    }
}

struct Happenings: Codable {
    
    var id: Int?
    var image: String?
    var date: String?
    var description: String?
    var title: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case date = "date"
        case description = "description"
        case title = "title"
    }
}
