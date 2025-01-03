//
//  ObjProfile.swift
//  Queen St
//
//  Created by iMac on 31/12/24.
//

import Foundation

struct ObjProfile: Codable {
    
    var status: Int?
    var message: String?
    var data: ObjProfileData?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

struct ObjProfileData: Codable {
    
    var id: Int?
    var title: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var dateOfBirth: String?
    var instagram: String?
    var linkedIn: String?
    var comapnyWebsite: String?
    var companyPosition: String?
    var recommendedBy: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case mobile = "mobile"
        case dateOfBirth = "dateOfBirth"
        case instagram = "instagram"
        case linkedIn = "linkedIn"
        case comapnyWebsite = "comapnyWebsite"
        case companyPosition = "companyPosition"
        case recommendedBy = "recommendedBy"
    }
}
