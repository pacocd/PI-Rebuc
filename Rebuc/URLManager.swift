//
//  URLManager.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 24/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import Alamofire

struct URLManager {

    static let shared: URLManager = URLManager()

    fileprivate func getBaseURL() -> String {
        let path: String? = Bundle.main.path(forResource: "Info", ofType: "plist")
        let dict: NSDictionary? = NSDictionary(contentsOfFile: path!)
        let urlServer: String = dict?["URL_Server"] as! String
        return urlServer
    }

    func getBaseRequestHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return headers
    }

    func getURL(from endpoint: Endpoint) -> String {
        let url = getBaseURL() + endpoint.getURL()
        return url
    }

}

protocol EndpointProtocol {
    func getURL() -> String
}

enum Endpoint: EndpointProtocol {
    case signUp, signIn, campusLocation, dependence, movementTag, ticketMovement, ticket, ticketState, userRole, admin
    func getURL() -> String {
        let basePath: String = "/api/v1/"
        switch self {
        case .signIn:
            return "/auth/sign_in"
        case .signUp:
            return "/auth"
        case .campusLocation:
            return basePath + "campus_locations"
        case .dependence:
            return basePath + "dependences"
        case .movementTag:
            return basePath + "movement_tags"
        case .ticketMovement:
            return basePath + "ticket_movements"
        case .ticket:
            return basePath + "tickets"
        case .ticketState:
            return basePath + "ticket_states"
        case .userRole:
            return basePath + "user_roles"
        case .admin:
            return basePath + "admin"
        }
    }
}
