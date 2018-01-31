//
//  PostsTableViewController.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import UIKit
import LoremIpsum

class PostsTableViewController: UITableViewController {
    var userId: Int?
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // get the list of users
        if let userId = userId {
            RestManager.shared.getPosts(userId: userId) { posts in
                if let posts = posts {
                    self.posts = posts
                    self.tableView.reloadData()
                } else {
                    UIAlertController.showAlert(in: self, withTitle: "Error", message: "Error getting posts.", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
                }
            }
        }
    }

    // MARK: - IBAction Methods

    @IBAction func addPost(_ sender: Any) {
        guard let userId = userId else { return }
        let post = Post(id: nil, userId: userId, title: LoremIpsum.sentence(), body: LoremIpsum.paragraph())
        RestManager.shared.createPost(post) { post in
            if let post = post {
                self.posts.insert(post, at: 0)
                self.tableView.reloadData()
            } else {
                UIAlertController.showAlert(in: self, withTitle: "Error", message: "Error creating post.", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
            }
        }
    }

    // MARK: - UITabeViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let postId = posts[indexPath.row].id else { return }
            RestManager.shared.deletePost(postId: postId) { error in
                if let error = error {
                    UIAlertController.showAlert(in: self, withTitle: "Error Deleting Post", message: error.localizedDescription, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
                } else {
                    self.posts.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            (segue.destination as? PostViewController)?.post = posts[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension Date {
    var time: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
}
