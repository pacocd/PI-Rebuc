//
//  LoginViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 24/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Login"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// Requests user login
    ///
    /// - Parameter sender: Any
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else { showBasicAlert(with: "El Email es requerido") ;return }
        guard let password = passwordTextField.text else { showBasicAlert(with: "El password es requerido") ;return }
        guard !email.isEmpty && !password.isEmpty else { showBasicAlert(with: "Ambos campos son requeridos") ;return }
        let fullEmail = email + "@ucol.mx"

        APIManager.shared.login(using: fullEmail, and: password, success: { (user, headers) in
            UserManager.shared.user = user
            UserManager.shared.saveOnDefaults(token: headers)
            let viewController: UIViewController = self.instantiate(viewController: "TicketsViewController", storyboard: "Tickets")
            let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
            NotificationCenter.default.post(name: .userDidSet, object: nil)
        }) { (error) in
            self.showBasicAlert(with: error.localizedDescription)
        }
    }

    /// Present Sign Up View Controller
    ///
    /// - Parameter sender: Any
    @IBAction func showSignUp(_ sender: Any) {
        let viewController = instantiate(viewController: "SignUpViewController", storyboard: "Authentication")
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        // navigationController?.pushViewController(viewController, animated: true)
        present(navigationController, animated: true, completion: nil)
    }

}
