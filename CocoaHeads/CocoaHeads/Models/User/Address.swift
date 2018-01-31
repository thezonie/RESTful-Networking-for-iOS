//
//  Address.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/23/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var postalCode: String
    var location: Location

    // from https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case postalCode = "zipcode"
        case location = "geo"
    }
}
