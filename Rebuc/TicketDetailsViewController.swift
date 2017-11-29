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
    @IBOutlet weak var moreOptionsButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    var responsablePickerView: UIPickerView = UIPickerView()
    var ticket: Ticket?

    lazy var moreOptionsActionSheet: UIAlertController = {
        let alertController: UIAlertController = UIAlertController(title: "Opciones", message: "Ticket: \(ticket?.id ?? 0)", preferredStyle: .actionSheet)
        let alertActionCloseTicket: UIAlertAction = UIAlertAction(title: "Cerrar Ticket", style: .destructive, handler: { (_) in
            self.ticket?.state.id = 3
            APIManager.shared.updateTicket(using: self.ticket!, success: { (newTicket) in
                self.ticket = newTicket
                self.dismissViewController()
            }) { (error) in
                self.showBasicAlert(with: error.localizedDescription)
            }
        })
        let alertActionCancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(alertActionCloseTicket)
        alertController.addAction(alertActionCancel)
        return alertController
    }()

    var responsable: Responsable?
    var responsables: [Responsable] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Detalles de Ticket"
        if UserManager.shared.user?.userRole.id == 3 {
            responsableTextView.isUserInteractionEnabled = false
            responsableTextView.backgroundColor = UIColor.grayTableViewSeparator
            assignResponsableButton.isEnabled = false
            assignResponsableButton.setTitleColor(UIColor.grayTableViewSeparator, for: .normal)
        } else {
            responsableTextView.isUserInteractionEnabled = true
            responsableTextView.inputView = responsablePickerView
            responsablePickerView.delegate = self
            responsablePickerView.dataSource = self
            assignResponsableButton.isEnabled = true
            assignResponsableButton.setTitleColor(UIColor.greenUcolTab, for: .normal)
            APIManager.shared.getObjects(of: Responsable.self, success: { (responsables) in
                let unorderedResponsables = responsables.flatMap({ (responsable) -> Responsable? in
                    if responsable.dependenceId == self.ticket?.user.dependenceId {
                        return responsable
                    } else if responsable.userRole.id == 1 {
                        return responsable
                    } else {
                        return nil
                    }
                })
                self.responsables = unorderedResponsables.sorted(by: { (r1, r2) -> Bool in
                    return r1.userRole.id < r2.userRole.id
                })
                self.responsablePickerView.reloadAllComponents()
            }, failure: { (error) in
                self.showBasicAlert(with: error.localizedDescription)
            })
        }

        if ticket?.state.id == 3 {
            messageTextView.isEnabled = false
            messageTextView.backgroundColor = UIColor.grayTableViewSeparator
            responsableTextView.isEnabled = false
            responsableTextView.backgroundColor = UIColor.grayTableViewSeparator
            assignResponsableButton.isEnabled = false
            assignResponsableButton.setTitleColor(.grayTableViewSeparator, for: .normal)
            sendMessageButton.isEnabled = false
            sendMessageButton.setTitleColor(.grayTableViewSeparator, for: .normal)
            moreOptionsButton.isEnabled = false
            moreOptionsButton.setTitleColor(.grayTableViewSeparator, for: .normal)
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
            Estado: \(ticket.state.name)
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
        if let responsable = responsable {
            ticket?.responsableId = responsable.id
            ticket?.state.id = 2
        } else {
            ticket?.responsableId = 0
            ticket?.state.id = 1
        }

        APIManager.shared.updateTicket(using: ticket!, success: { (newTicket) in
            self.ticket = newTicket
            self.updateUI(using: newTicket)
        }) { (error) in
            self.showBasicAlert(with: error.localizedDescription)
        }
    }

    
    @IBAction func sendMessage(_ sender: Any) {
    }

    @IBAction func showOptionsMenu(_ sender: Any) {
        present(moreOptionsActionSheet, animated: true, completion: nil)
    }

}

extension TicketDetailsViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        responsable = responsables[row]
        responsableTextView.text = "\(responsables[row].name) \(responsables[row].fatherLastName ?? "") \(responsables[row].motherLastName ?? "")"
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(responsables[row].name) \(responsables[row].fatherLastName ?? "") \(responsables[row].motherLastName ?? "") (\(responsables[row].userRole.name.first ?? "U"))"
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
