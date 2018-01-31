//
//  Photo.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/23/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var id: Int
    var albumId: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
