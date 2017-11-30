//
//  BaseViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

/// BaseViewController do navigation and menu's options management for all view controllers
class BaseViewController: UIViewController {

    lazy var dismissButton: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissViewController))
        return button
    }()
    lazy var profileButton: UIBarButtonItem = {
        let image = UIImage(named: "mobile-menu-icon")
        let button: UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.done, target: self, action: #selector(presentUserProfileOptions))
        button.tintColor = nil
        return button
    }()
    lazy var userActionSheet: UIAlertController = {
        let alertController: UIAlertController = UIAlertController(title: "Menú", message: nil, preferredStyle: .actionSheet)
        return alertController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if isModal() {
            navigationItem.leftBarButtonItem = dismissButton
        }
        if UserManager.shared.isUserLogged() {
            navigationItem.rightBarButtonItem = profileButton
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .userDidSet, object: nil)

        if !self.isKind(of: TicketsListViewController.self) && !self.isKind(of: UsersListViewController.self) {
            let tapGestureForDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGestureForDismissKeyboard)
        }
        let statusBarView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UIApplication.shared.statusBarFrame.height))
        view.addSubview(statusBarView)
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Update controller UI
    @objc func updateUI() {
        if let user = UserManager.shared.user {
            DispatchQueue.main.async {
                self.userActionSheet.message = "\(user.name) \(user.fatherLastName ?? "") \(user.motherLastName ?? "")"
                if self.userActionSheet.actions.count == 0 {
                    if UserManager.shared.user?.userRole.id == 1 {
                        let alertActionUsersList: UIAlertAction = UIAlertAction(title: "Lista de Usuarios", style: UIAlertActionStyle.default, handler: { (_) in
                            let viewController: UIViewController = self.instantiate(viewController: "UsersListViewController", storyboard: "Users")
                            let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
                            self.present(navigationController, animated: true, completion: nil)
                        })
                        self.userActionSheet.addAction(alertActionUsersList)
                    }
                    let alertActionSignOut: UIAlertAction = UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: { (_) in
                        self.logout()
                    })
                    let alertActionCancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                    self.userActionSheet.addAction(alertActionSignOut)
                    self.userActionSheet.addAction(alertActionCancel)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.userActionSheet.message = nil
            }
        }
    }

    /// Destroy User's session and present Login
    @objc func logout() {
        UserManager.shared.user = nil
        UserManager.shared.removeSessionFromDefaults()
        let viewController: UIViewController = instantiate(viewController: "LoginViewController", storyboard: "Authentication")
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }

    /// Show User's menu in Navigation Bar
    @objc func presentUserProfileOptions() {
        present(userActionSheet, animated: true, completion: nil)
    }

    /// Check if current controller is modal
    ///
    /// - Returns: True if is modal, False if is not
    func isModal() -> Bool {
        if let index = navigationController?.viewControllers.index(of: self), index > 0 {
            return false
        }
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

    /// Dismiss Modal View Controller
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    /// Dismiss Keyboard if touch out of UITextField / UITextView
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
