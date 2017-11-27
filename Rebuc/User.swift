//
//  User.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable, Model {

    var id: Int = 0
    var name: String = ""
    var fatherLastName: String!
    var motherLastName: String?
    var email: String!
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
        dependence          <- map["dependence"]
        userRole            <- map["user_role"]
    }

    func getUrl() -> String {
        return ""
    }

}
