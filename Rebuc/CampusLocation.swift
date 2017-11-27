//
//  CampusLocation.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class CampusLocation: Mappable, Model {

    var id: Int = 0
    var name: String = ""

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }

    func getUrl() -> String {
        return URLManager.shared.getURL(from: .campusLocation)
    }

}
