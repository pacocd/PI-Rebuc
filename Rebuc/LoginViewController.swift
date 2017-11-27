//
//  LoginViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 24/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else { showBasicAlert(with: "El Email es requerido") ;return }
        guard let password = passwordTextField.text else { showBasicAlert(with: "El password es requerido") ;return }
        guard !email.isEmpty && !password.isEmpty else { showBasicAlert(with: "Ambos campos son requeridos") ;return }
        let fullEmail = email + "@ucol.mx"

        APIManager.shared.login(using: fullEmail, and: password, success: { (user) in
            print(user.name)
        }) { (error) in
            self.showBasicAlert(with: error.localizedDescription)
        }
    }

    
    @IBAction func showSignUp(_ sender: Any) {
        let viewController = instantiate(viewController: "SignUpViewController", storyboard: "Authentication")
        navigationController?.pushViewController(viewController, animated: true)
    }

}
