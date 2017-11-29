//
//  UsersListViewController.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 29/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class UsersListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var users: [Admin] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Usuarios"
        APIManager.shared.getObjectsWithToken(of: Admin.self) { (admins) in
            self.users = admins.sorted(by: { (a1, a2) -> Bool in
                return a1.userRole.id < a2.userRole.id
            })
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UsersListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

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

extension UsersListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath)
        cell.textLabel?.text = "\(users[indexPath.row].name) \(users[indexPath.row].fatherLastName ?? "") \(users[indexPath.row].motherLastName ?? "")"
        cell.detailTextLabel?.text = "\(users[indexPath.row].dependence.name) (\(users[indexPath.row].userRole.name))"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

}
