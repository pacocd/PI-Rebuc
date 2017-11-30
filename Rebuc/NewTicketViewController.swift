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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Nuevo Ticket"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Request to create a new Ticket
    ///
    /// - Parameter sender: Any
    @IBAction func createTicket(_ sender: Any) {
        guard let description = descriptionTextView.text else { return }
        guard !description.isEmpty else { showBasicAlert(with: "La descripción es obligatoria"); return }

        APIManager.shared.generateTicket(sending: description, success: { (ticket) in
            self.dismissViewController()
        }) { (error) in
            self.showBasicAlert(with: error.localizedDescription)
        }
    }

}
