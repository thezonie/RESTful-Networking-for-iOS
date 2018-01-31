//
//  Comment.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/23/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}
