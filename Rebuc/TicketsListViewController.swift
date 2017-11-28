//
//  TicketsListViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 27/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class TicketsListViewController: BaseViewController {

    var tickets: [Ticket] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.getObjectsWithToken(of: Ticket.self) { (ticketsRequest) in
            self.tickets = ticketsRequest
            self.tableView.reloadData()
        }
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Tickets"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func createTicket(_ sender: Any) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TicketsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.grayTableViewSeparator
        return view
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.grayTableViewSeparator
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

}

extension TicketsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath)
        cell.textLabel?.text = "Estado: \(tickets[indexPath.row].state.name)"
        cell.detailTextLabel?.text = tickets[indexPath.row].description
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

}
