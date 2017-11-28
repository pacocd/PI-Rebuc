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
    @IBOutlet weak var createTicketsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Tickets"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserManager.shared.user?.userRole.id != 3 {
            createTicketsButton.isEnabled = false
            createTicketsButton.setTitleColor(UIColor.grayTableViewSeparator, for: .normal)
        }
        APIManager.shared.getObjectsWithToken(of: Ticket.self) { (ticketsRequest) in
            if UserManager.shared.user?.userRole.id == 2 {
                let ticketsFiltered = ticketsRequest.flatMap({ (ticket) -> Ticket? in
                    if let user = UserManager.shared.user {
                        if user.dependenceId == ticket.user.dependenceId {
                            return ticket
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                })
                self.tickets = ticketsFiltered
            } else {
                self.tickets = ticketsRequest
            }
            self.tableView.reloadData()
        }
    }

    @IBAction func createTicket(_ sender: Any) {
        let viewController: UIViewController = instantiate(viewController: "NewTicketViewController", storyboard: "Tickets")
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
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
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        switch tickets[indexPath.row].state.id {
        case 1:
            cell.imageView?.image = UIImage(named: "ticket-icon-active")
            break
        case 2:
            cell.imageView?.image = UIImage(named: "ticket-icon-process")
            break
        case 3:
            cell.imageView?.image = UIImage(named: "ticket-icon-closed")
            break
        default:
            cell.imageView?.image = UIImage(named: "ticket-icon-active")
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

}
