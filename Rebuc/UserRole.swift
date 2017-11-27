//
//  UserRole.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class UserRole: Mappable, Model {

    var id: Int = 0
    var name: String = ""

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }

    static func getUrl() -> String {
        return URLManager.shared.getURL(from: .userRole)
    }

    static func singularNodeName() -> String {
        return "user_role"
    }

    static func pluralNodeName() -> String {
        return "user_roles"
    }

}
