//
//  Protocols.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation


/// Model protocol using ModelProperty, ModelURL and ModelNode
@objc protocol Model: ModelProperty, ModelURL, ModelNode {
}

/// ModelProperty protocol defines basic properties for Models
@objc protocol ModelProperty {
    var id: Int { get set }
    @objc optional var name: String { get set }
}

/// ModelURL protocol defines to get URL for current Model
@objc protocol ModelURL {
    static func getUrl() -> String
}

/// ModelNode protocol defines to get node name if is singular or plural
@objc protocol ModelNode {
    static func singularNodeName() -> String
    static func pluralNodeName() -> String
}
