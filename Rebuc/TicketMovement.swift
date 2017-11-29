//
//  TicketMovement.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 28/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class TicketMovement: Mappable, Model {

    var id: Int = 0
    var description: String = ""
    var movementTagId: Int!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id              <- map["id"]
        description     <- map["description"]
        movementTagId   <- map["movement_tag_id"]
    }

    static func getUrl() -> String {
        return URLManager.shared.getURL(from: .ticketMovement)
    }

    static func singularNodeName() -> String {
        return "ticket_movement"
    }

    static func pluralNodeName() -> String {
        return "ticket_movements"
    }

}
