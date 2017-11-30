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

    /// URLManager singleton
    static let shared: URLManager = URLManager()

    /// Private method to get base url of API
    ///
    /// - Returns: API's base url
    fileprivate func getBaseURL() -> String {
        let path: String? = Bundle.main.path(forResource: "Info", ofType: "plist")
        let dict: NSDictionary? = NSDictionary(contentsOfFile: path!)
        let urlServer: String = dict?["URL_Server"] as! String
        return urlServer
    }

    /// Generate basic headers to request without authentication
    ///
    /// - Returns: HTTP Basic headers
    func getBaseRequestHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return headers
    }

    /// URL for specific endpoint using Endpoint enum
    ///
    /// - Parameter endpoint: Endpoint to get URL
    /// - Returns: API's URL to specific endpoint
    func getURL(from endpoint: Endpoint) -> String {
        let url = getBaseURL() + endpoint.getURL()
        return url
    }

}

/// Protocol to define getURL as required method
protocol EndpointProtocol {
    func getURL() -> String
}

/// Endpoint enum for every API endpoint
///
/// - signUp: Sign UP
/// - signIn: Sign In / Log In
/// - campusLocation: Campus Location
/// - dependence: Dependence
/// - movementTag: Movement Tag
/// - ticketMovement: Ticket Movement
/// - ticket: Ticket
/// - ticketState: Ticket State
/// - userRole: User Role
/// - admin: Admin
/// - userInfo: User Information
/// - responsable: Responsable
enum Endpoint: EndpointProtocol {
    case signUp, signIn, campusLocation, dependence, movementTag, ticketMovement, ticket, ticketState, userRole, admin, userInfo, responsable
    /// Get specific path for base URL
    ///
    /// - Returns: Specific path
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
        case .userInfo:
            return basePath + "user"
        case .responsable:
            return basePath + "responsables"
        }

    }
}
