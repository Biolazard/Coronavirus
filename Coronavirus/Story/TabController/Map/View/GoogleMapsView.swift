//
//  GoogleMaps.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import GoogleMaps

class GoogleMapsView: GMSMapView, GoogleMapsProtocol {
    
    func setAnnotation(_ infoCoronavirus: [Coronavirus]) {
        infoCoronavirus.forEach { c in
            if c.confirmed > 0 {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: c.latitude ?? 0, longitude: c.longitude ?? 0)
                marker.title = c.country
                marker.snippet = "Confirmed \(c.confirmed)"
                marker.map = self
            }
        }
    }
    
}
