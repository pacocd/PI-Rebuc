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
    var responsablePickerView: UIPickerView = UIPickerView()

    var ticket: Ticket?
    var responsable: Responsable?
    var responsables: [Responsable] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Detalles de Ticket"
        if UserManager.shared.user?.userRole.id == 3 {
            responsableTextView.isUserInteractionEnabled = false
        } else {
            responsableTextView.isUserInteractionEnabled = true
            responsableTextView.inputView = responsablePickerView
            responsablePickerView.delegate = self
            responsablePickerView.dataSource = self
            APIManager.shared.getObjects(of: Responsable.self, success: { (responsables) in
                self.responsables = responsables.flatMap({ (responsable) -> Responsable? in
                    if responsable.dependenceId == UserManager.shared.user?.dependenceId {
                        return responsable
                    } else if responsable.userRole.id == 1 {
                        return responsable
                    } else {
                        return nil
                    }
                })
                self.responsablePickerView.reloadAllComponents()
            }, failure: { (error) in
                self.showBasicAlert(with: error.localizedDescription)
            })
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
                self.responsable = responsable
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

extension TicketDetailsViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        responsable = responsables[row]
        responsableTextView.text = "\(responsables[row].name) \(responsables[row].fatherLastName ?? "") \(responsables[row].motherLastName ?? "")"
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(responsables[row].name) \(responsables[row].fatherLastName ?? "") \(responsables[row].motherLastName ?? "")"
    }

}

extension TicketDetailsViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return responsables.count
    }

}
