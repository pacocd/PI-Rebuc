//
//  TicketDetailsViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 28/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class TicketDetailsViewController: UIViewController {

    @IBOutlet weak var ticketStateImageView: UIImageView!
    @IBOutlet weak var ticketNumberLabel: UILabel!
    @IBOutlet weak var responsableTextView: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: UITextField!
    @IBOutlet weak var assignResponsableButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func assignResponsable(_ sender: Any) {
    }

    
    @IBAction func sendMessage(_ sender: Any) {
    }

}
