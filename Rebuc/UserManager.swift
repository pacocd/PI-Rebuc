//
//  UserManager.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import Alamofire

/// UserManager do all interactions with UserDefults to store and manage local Data
struct UserManager {

    static var shared: UserManager = UserManager()
    var user: User?

}

// MARK: - Defaults data modifications
extension UserManager {

    /// Save all user's session data in UserDefaults
    ///
    /// - Parameter value: Dictionary with user credentials
    func saveOnDefaults(token value: [String: Any]) {
        let defaults: UserDefaults = UserDefaults.standard
        if let accessToken = value["Access-Token"] as? String{
            if let client = value["Client"] as? String {
                if let uid = value["Uid"] as? String {
                    defaults.set(accessToken, forKey: "user-token-auth")
                    defaults.set(client, forKey: "user-client-auth")
                    defaults.set(uid, forKey: "user-uid-auth")
                }
            }
        }
    }

    /// Update User's acces token in UserDefaults after a request
    ///
    /// - Parameter value: User's access token
    func update(token value: String?) {
        let defaults: UserDefaults = UserDefaults.standard
        if let value = value {
            defaults.set(value, forKey: "user-token-auth")
            defaults.synchronize()
        }
    }

    /// Remove user's session data from UserDefaults
    func removeSessionFromDefaults() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: "user-token-auth")
        defaults.removeObject(forKey: "user-client-auth")
        defaults.removeObject(forKey: "user-uid-auth")
    }

}

// MARK: - Check for stored data in Defaults
extension UserManager {

    /// Check in defaults is there is any User's Data
    ///
    /// - Returns: Boolean flag is User is logged or not
    func isUserLogged() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: "user-token-auth") {
            return true
        } else {
            return false
        }
    }

}

// MARK: - Get stored data from Defaults
extension UserManager {

    /// Generate headers for requests using User's session data stored in UserDefaults
    ///
    /// - Returns: HTTPHeaders for requests
    func getHeadersForAuthentication() -> HTTPHeaders {
        let defaults: UserDefaults = UserDefaults.standard

        let headers: HTTPHeaders = [
            "access-token": defaults.object(forKey: "user-token-auth") as! String,
            "client": defaults.object(forKey: "user-client-auth") as! String,
            "uid": defaults.object(forKey: "user-uid-auth") as! String,
            "Content-Type": "application/json"
        ]

        return headers
    }

}
