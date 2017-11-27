//
//  Protocols.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation

@objc protocol Model {
    var id: Int { get set }
    @objc optional var name: String { get set }
    static func getUrl() -> String
    static func singularNodeName() -> String
    static func pluralNodeName() -> String
}
