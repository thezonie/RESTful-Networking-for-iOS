//
//  CommentsTableViewController.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    var postId: Int?
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // get the list of users
        if let postId = postId {
            RestManager.shared.getComments(postId: postId) { comments in
                if let comments = comments {
                    self.comments = comments
                    self.tableView.reloadData()
                } else {
                    UIAlertController.showAlert(in: self, withTitle: "Error", message: "Error getting comments.", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
                }
            }
        }
    }

    // MARK: - UITabeViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = comments[indexPath.row]
        cell.textLabel?.text = comment.body
        cell.detailTextLabel?.text = comment.email
        return cell
    }
}
