//
//  APIManager.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct APIManager {

    static let shared: APIManager = APIManager()

    func login(using email: String, and password: String, success: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {

        let url = URLManager.shared.getURL(from: .signIn)
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        let headers: HTTPHeaders = URLManager.shared.getBaseRequestHeaders()

        request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any] {
                    if let userData = json["data"] as? [String: Any] {
                        if let user = Mapper<User>().map(JSON: userData) {
                            success(user)
                        }
                    }
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

}
