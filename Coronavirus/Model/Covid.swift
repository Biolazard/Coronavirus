//
//  Model.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import CoreLocation

struct Covid {
    let country: String
    let lastUpdate: String
    let confirmed: String
    let deaths: String
    let recovered: String
    let coordinates: CLLocationCoordinate2D
}
