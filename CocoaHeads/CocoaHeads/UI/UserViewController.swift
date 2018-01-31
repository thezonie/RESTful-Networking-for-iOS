//
//  UserViewController.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var user: User?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!

    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var suite: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var postalCode: UILabel!

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = user?.name
        email.text = user?.email

        street.text = user?.address.street
        suite.text = user?.address.suite
        city.text = user?.address.city
        postalCode.text = user?.address.postalCode

        phone.text = user?.phone
        website.text = user?.website
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? PostsTableViewController)?.userId = user?.id
    }
}
