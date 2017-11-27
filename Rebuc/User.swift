//
//  User.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {

    var id: Int!
    var name: String!
    var fatherLastName: String!
    var motherLastName: String?
    var email: String!
    var dependence: [String: Any]!
    var userRole: [String: Any]!

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
}
