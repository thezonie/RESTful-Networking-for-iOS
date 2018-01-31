//
//  User.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/23/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}
