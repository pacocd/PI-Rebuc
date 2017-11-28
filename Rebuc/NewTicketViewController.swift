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
    var responsablesPickerView: UIPickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.getObjects(of: Responsable.self, success: { (responsables) in
            self.responsables = responsables.flatMap({ (responsable) in
                if responsable.dependence.id == UserManager.shared.user?.dependence.id {
                    return responsable
                } else {
                    return nil
                }
            })
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
