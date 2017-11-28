//
//  NewTicketViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class NewTicketViewController: BaseViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var responsableTextField: UITextField!
    var responsables: [Responsable] = []
    var selectedResponsable: Responsable?
    var responsablesPickerView: UIPickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        responsableTextField.inputView = responsablesPickerView
        responsablesPickerView.dataSource = self
        responsablesPickerView.delegate = self
        APIManager.shared.getObjects(of: Responsable.self, success: { (responsables) in
            self.responsables = responsables.flatMap({ (responsable) in
                if responsable.dependence.id == UserManager.shared.user?.dependence.id {
                    return responsable
                } else if responsable.userRole.id == 1 {
                    return responsable
                } else {
                    return nil
                }
            })
            self.responsablesPickerView.reloadAllComponents()
        }) { (error) in
            self.showBasicAlert(with: error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createTicket(_ sender: Any) {
    }

}

extension NewTicketViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return responsables.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}

extension NewTicketViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(responsables[row].name) \(responsables[row].fatherLastName ?? "") \(responsables[row].motherLastName ?? "")"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        responsableTextField.text = "\(responsables[row].name) \(responsables[row].fatherLastName ?? "") \(responsables[row].motherLastName ?? "")"
        selectedResponsable = responsables[row]
    }
}
