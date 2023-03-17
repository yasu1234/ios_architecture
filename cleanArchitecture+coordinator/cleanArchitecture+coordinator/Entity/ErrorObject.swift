import ObjectMapper

enum APIError: Error {
    case unknown
    case error(message: String?, type: String?)
    case netWorkConnectionError
}

class ErrorObject {
    var message: String?
    var type: String?
    
    init() {
    }
    
    required init(map: Map) {
    }
}

extension ErrorObject: Mappable {
    func mapping(map: Map) {
        message <- map["message"]
        type <- map["type"]
    }
}
