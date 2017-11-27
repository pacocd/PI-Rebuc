//
//  Dependence.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class Dependence: Mappable, Model {

    var id: Int = 0
    var name: String = ""
    var campusLocation: CampusLocation!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        campusLocation  <- map["campus_location"]
    }

    static func getUrl() -> String {
        return URLManager.shared.getURL(from: .dependence)
    }

    static func singularNodeName() -> String {
        return "dependence"
    }

    static func pluralNodeName() -> String {
        return "dependences"
    }

}
