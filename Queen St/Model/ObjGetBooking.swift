//
//  ObjGetBooking.swift
//  Queen St
//
//  Created by iMac on 03/01/25.
//

import Foundation

struct ObjGetBooking: Codable {
    
    var status: Int?
    var message: String?
    var data: ObjGetBookingData?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}
    
struct ObjGetBookingData: Codable {
    
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
