//
//  Admin.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 29/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class Admin: Mappable, Model {

    var id: Int = 0
    var name: String = ""
    var fatherLastName: String?
    var motherLastName: String?
    var email: String!
    var dependenceId: Int!
    var dependence: Dependence!
    var userRole: UserRole!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        fatherLastName      <- map["father_last_name"]
        motherLastName      <- map["mother_last_name"]
        email               <- map["uid"]
        dependenceId        <- map["dependence_id"]
        dependence          <- map["dependence"]
        userRole            <- map["user_role"]
    }

    static func getUrl() -> String {
        return URLManager.shared.getURL(from: .admin)
    }

    static func singularNodeName() -> String {
        return "user"
    }

    static func pluralNodeName() -> String {
        return "users"
    }

}
