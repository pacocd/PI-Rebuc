//
//  APIError.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation

class APIError: NSError {

    var message: String = "Algo salió mal y no se pudo completar la operación"

    init(message: String? = nil, code: Int = 0) {
        if let _message = message {
            self.message = _message
        }

        super.init(domain: "pacocd.Rebuc", code: code, userInfo: [NSLocalizedDescriptionKey: self.message])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }

}
