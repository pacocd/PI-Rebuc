//
//  TicketDetailsViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 28/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class TicketDetailsViewController: BaseViewController {

    @IBOutlet weak var ticketStateImageView: UIImageView!
    @IBOutlet weak var ticketNumberLabel: UILabel!
    @IBOutlet weak var responsableTextView: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: UITextField!
    @IBOutlet weak var assignResponsableButton: UIButton!

    var ticket: Ticket?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Detalles de Ticket"
        if UserManager.shared.user?.userRole.id == 3 {
            responsableTextView.isUserInteractionEnabled = false
        } else {
            responsableTextView.isUserInteractionEnabled = true
        }
        if let ticket = ticket {
            updateUI(using: ticket)
        }
        // Do any additional setup after loading the view.
    }

    func updateUI(using ticket: Ticket) {
        DispatchQueue.main.async {
            switch ticket.state.id {
            case 1:
                self.ticketStateImageView.image = UIImage(named: "ticket-icon-active")
            case 2:
                self.ticketStateImageView.image = UIImage(named: "ticket-icon-process")
            case 3:
                self.ticketStateImageView.image = UIImage(named: "ticket-icon-closed")
            default:
                self.ticketStateImageView.image = UIImage(named: "ticket-icon")
            }
            self.ticketNumberLabel.text = "Ticket número \(ticket.id)"
            self.descriptionLabel.text = """
                Descripción:
                \(ticket.description ?? "")
            """
            if let responsable = ticket.responsable {
                self.responsableTextView.text = "\(responsable.name) \(responsable.fatherLastName ?? "") \(responsable.motherLastName ?? "")"
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func assignResponsable(_ sender: Any) {
    }

    
    @IBAction func sendMessage(_ sender: Any) {
    }

    @IBAction func showOptionsMenu(_ sender: Any) {
    }

}
