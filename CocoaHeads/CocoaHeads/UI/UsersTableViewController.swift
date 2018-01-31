//
//  UsersTableViewController.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import UIKit
import UIAlertController_Blocks

class UsersTableViewController: UITableViewController {
    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // get the list of users
        RestManager.shared.getUsers { users in
            if let users = users {
                self.users = users
                self.tableView.reloadData()
            } else {
                UIAlertController.showAlert(in: self, withTitle: "Error", message: "Error getting users.", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
            }
        }
    }
    
    // MARK: - UITabeViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }

    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            (segue.destination as? UserViewController)?.user = users[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
        } 
    }
}
