//
//  Todo.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/23/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

struct Todo: Codable {
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
}
