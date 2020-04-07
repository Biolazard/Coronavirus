//
//  Coronavirus.swift
//  Coronavirus
//
//  Created by Marius Lazar on 07/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

struct Coronavirus: Codable {
    var country: String
    var confirmed: Int
    var recovered: Int
    var critical: Int
    var deaths: Int
    var latitude: Double?
    var longitude: Double?
}
