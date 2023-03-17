import ObjectMapper

class App {
    var updateRequired = false
    var notificationTitle: String?
    var notificationMessage: String?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
}

extension App: Mappable {
    
    func mapping(map: Map) {
        updateRequired <- map["update_flg"]
        notificationTitle <- map["title"]
        notificationMessage <- map["message"]
    }
}
