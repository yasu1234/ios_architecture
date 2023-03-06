//
//  USer.swift
//  mvvm+rxswift
//
//  Created by 神代泰宏 on 2023/03/05.
//

import ObjectMapper

class User {
    var description: String?
    var followCount = 0
    var followerCount = 0
    var name: String?
    var imageUrl: String?
    
    init() {
    }
    
    required init(map: Map) {
    }
}

extension User: Mappable {
    func mapping(map: Map) {
        description <- map["description"]
        followCount <- map["followees_count"]
        followerCount <- map["followers_count"]
        name <- map["name"]
        imageUrl <- map["profile_image_url"]
    }
}
