//
//  BaseViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var dismissButton: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissViewController))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if isModal() {
            navigationItem.leftBarButtonItem = dismissButton
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isModal() -> Bool {
        if isBeingPresented {
            return true
        }
        if presentingViewController != nil {
            return true
        }
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }

    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
