//
//  TicketState.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class TicketState: Mappable, Model {

    var id: Int = 0
    var name: String = ""

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }

    static func getUrl() -> String {
        return URLManager.shared.getURL(from: .ticketState)
    }

    static func singularNodeName() -> String {
        return "ticket_state"
    }

    static func pluralNodeName() -> String {
        return "ticket_states"
    }

}
