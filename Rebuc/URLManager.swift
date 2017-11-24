//
//  URLManager.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 24/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation

struct URLManager {

    static let shared: URLManager = URLManager()

    fileprivate func getBaseURL() -> String {
        let path: String? = Bundle.main.path(forResource: "Info", ofType: "plist")
        let dict: NSDictionary? = NSDictionary(contentsOfFile: path!)
        let urlServer: String = dict?["URL_Server"] as! String
        return urlServer
    }

}
