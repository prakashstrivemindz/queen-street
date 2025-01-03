
import UIKit

let environment = 1

struct APIServerConstants {
    
    // Image Base URL
    static let imageBaseURL = URL(string: "")!
    
    // SERVER URL
    static let staggingServerURL = URL(string: "")!
    static let liveServerURL = URL(string: "https://queenst.co.uk/wp-json/custom/v1/")!
    
    static let serverBaseURL = liveServerURL
    
    static let serverKey = ""
    static let serverTimeout = 30.0
    
}

struct webViewURLs
{
    static var register = "https://queenst.co.uk/membership/"
}


protocol EndpointType {
    var apiPath: String { get }
    var apiRequestType: String { get }
}

enum APIConstants {
    
    case demo
    case signin
    case memberDetails
    case profile
    case updateProfile
    case membershipDetails
    case happenings
    case logout
    case getBooking(Id: Int)
    case cancelBooking(Id: String)
    
//    case homeCategoryAPI(page: Int)
 
}

extension APIConstants: EndpointType {
    
    var apiPath: String {
        
        switch self {
        case .demo:
            return "user"
            
        case .signin:
            return "signin"
            
        case .memberDetails:
            return "member-details"
            
        case .profile:
            return "profile"
            
        case .updateProfile:
            return "update-profile"
            
        case .membershipDetails:
            return "membership"
            
        case .happenings:
            return "happenings"
            
        case .logout:
            return "logout"
            
        case .getBooking(let Id):
            return "getBooking?id=\(Id)"
            
        case .cancelBooking(let Id):
            return "cancel-booking?id=\(Id)"
            
//        case .homeCategoryAPI(let page):
//            return "categories/home/\(page)"
      
        }
    }
    
    var apiRequestType: String {
        
        switch self {
    
        case .demo:
            return "GET"
            
//        case .demo :
//            return "PATCH"
            
        default:
            return "POST"
        }
    }
}
