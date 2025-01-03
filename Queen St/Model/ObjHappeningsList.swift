//
//  ObjHappeningsList.swift
//  Queen St
//
//  Created by iMac on 02/01/25.
//

import Foundation

struct ObjHappeningsList: Codable {
    
    var status: Int?
    var message: String?
    var data: [ObjHappeningsListData]?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

struct ObjHappeningsListData: Codable {
    
    var id: Int?
    var title: String?
    var image: String?
    var date: String?
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
        case date = "date"
        case description = "description"
    }
}
