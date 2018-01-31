//
//  PostViewController.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = post?.body
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? CommentsTableViewController)?.postId = post?.id
    }
}
