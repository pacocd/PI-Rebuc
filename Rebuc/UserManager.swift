//
//  UserManager.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import Alamofire

struct UserManager {

    static let shared: UserManager = UserManager()
    var user: User?

    func saveOnDefaults(token value: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: "user-token-auth")
        defaults.synchronize()
    }

    func saveOnDefaults(client value: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: "user-client-auth")
        defaults.synchronize()
    }

    func saveOnDefaults(uid value: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: "user-uid-auth")
        defaults.synchronize()
    }

    func getRemoveSessionFromDefaults() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: "user-token-auth")
        defaults.removeObject(forKey: "user-client-auth")
        defaults.removeObject(forKey: "user-uid-auth")
        defaults.synchronize()
    }

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
