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

    func showBasicAlert(with message: String) {
        let alertController: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        DispatchQueue.main.async { [unowned self] in
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

extension UIColor {

    class var greenUcolTab: UIColor {
        return UIColor(red: 57 / 255, green: 165 / 255, blue: 83 / 255, alpha: 1)
    }

    class var grayTableViewSeparator: UIColor {
        return UIColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 1)
    }

    class var graySweet: UIColor {
        return UIColor(red: 246 / 255, green: 246 / 255, blue: 246 / 255, alpha: 1)
    }

    class var greenSweet: UIColor {
        return UIColor(red: 209 / 255, green: 255 / 255, blue: 218 / 255, alpha: 1)
    }

    class var redSweet: UIColor {
        return UIColor(red: 255 / 255, green: 226 / 255, blue: 216 / 255, alpha: 1)
    }

}

extension Notification.Name {

    static var userDidSet: Notification.Name {
        return Notification.Name("UserDidSet")
    }

    static var userDidDeleted: Notification.Name {
        return Notification.Name("UserDidDeleted")
    }

}
