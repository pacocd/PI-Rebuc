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
    lazy var profileButton: UIBarButtonItem = {
        let image = UIImage(named: "user-icon")
        let button: UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.done, target: self, action: #selector(presentUserProfileOptions))
        button.tintColor = nil
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if isModal() {
            navigationItem.leftBarButtonItem = dismissButton
        }
        if let _ = UserManager.shared.user {
            navigationItem.rightBarButtonItem = profileButton
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func presentUserProfileOptions() {
        let alertController: UIAlertController = UIAlertController(title: "Perfil de Usuario", message: nil, preferredStyle: .actionSheet)
        let alertActionSignOut: UIAlertAction = UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: nil)
        let alertActionCancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(alertActionSignOut)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
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
