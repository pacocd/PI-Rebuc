//
//  SignUpViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 24/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var namesTextField: UITextField!
    @IBOutlet weak var fatherLastNameTextField: UITextField!
    @IBOutlet weak var motherLastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var dependenceTextField: UITextField!
    var dependencePicker: UIPickerView = UIPickerView()
    var dependences: [Dependence] = []
    var pickedDependence: Dependence?

    override func viewDidLoad() {
        super.viewDidLoad()

        dependencePicker.dataSource = self
        dependencePicker.delegate = self

        APIManager.shared.getObjects(of: Dependence.self, success: { (dependences) in
            self.dependences = dependences
            self.dependencePicker.reloadAllComponents()
        }) { (error) in
            print(error)
        }
        dependenceTextField.inputView = dependencePicker
        navigationItem.title = "Registro"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(_ sender: Any) {
        guard let names = namesTextField.text else { return }
        guard let fatherLastName = fatherLastNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let passwordConfirmation = passwordConfirmationTextField.text else { return }
        guard !names.isEmpty && !fatherLastName.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty  && !(dependenceTextField.text?.isEmpty)! else { showBasicAlert(with: "Todos los campos con * son requeridos"); return }
        guard let dependenceId = pickedDependence?.id else { return }
        guard password.count > 7 && passwordConfirmation.count > 7 else { showBasicAlert(with: "La contraseña es muy corta (Mínimo 8 caracteres)"); return }
        guard password == passwordConfirmation else { showBasicAlert(with: "La contraseña y su confirmación deben coincidir"); return }

        APIManager.shared.signUp(using: email, password, passwordConfirmation, names, fatherLastName, motherLastNameTextField.text, dependenceId, success: { (user, headers) in
            print(user)
        }) { (error) in
            self.showBasicAlert(with: error.localizedDescription)
        }
    }

}

extension SignUpViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dependences.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}

extension SignUpViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dependences[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedDependence = dependences[row]
        dependenceTextField.text = dependences[row].name
    }

}
