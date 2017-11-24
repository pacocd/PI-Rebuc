//
//  Extensions.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 24/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

extension UIViewController {

    func instantiate(viewController identifier: String, storyboard name: String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }

}
