import Foundation
import Alamofire

struct APIConstant {
    enum Route: String {
        case authenticatedUser = "/authenticated_user"
        case app = "/app"
    }
    
    static var host: String {
        return Bundle.main.object(forInfoDictionaryKey: "API Host") as? String ?? ""
    }
    
    static var headers: HTTPHeaders {
        var params: HTTPHeaders = [:]
        
        params["Accept"] = "application/json"
        
        return params
    }
}
