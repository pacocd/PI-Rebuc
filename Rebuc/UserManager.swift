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

    static var shared: UserManager = UserManager()
    var user: User?

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

        defaults.synchronize()
    }

    func removeSessionFromDefaults() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: "user-token-auth")
        defaults.removeObject(forKey: "user-client-auth")
        defaults.removeObject(forKey: "user-uid-auth")
        defaults.synchronize()
    }

    func isUserLogged() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: "user-token-auth") {
            return true
        } else {
            return false
        }
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
