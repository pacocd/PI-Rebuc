//
//  Ticket.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import ObjectMapper

class Ticket: Mappable, Model {

    var id: Int = 0
    var description: String!
    var state: TicketState!
    var responsable: Responsable?
    var createdAt: Date!
    var endedAt: Date?
    var user: User!
    var userId: Int!
    var responsableId: Int = 0

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id              <- map["id"]
        description     <- map["description"]
        state           <- map["ticket_state"]
        createdAt       <- (map["created_at"], DateTransform())
        endedAt         <- (map["end_date"], DateTransform())
        responsable     <- map["responsable"]
        user            <- map["user"]
        userId          <- map["user_id"]
        responsableId   <- map["responsable_id"]
    }

    static func getUrl() -> String {
        return URLManager.shared.getURL(from: .ticket)
    }

    static func singularNodeName() -> String {
        return "ticket"
    }

    static func pluralNodeName() -> String {
        return "tickets"
    }

}
