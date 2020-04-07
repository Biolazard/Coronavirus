//
//  MapViewModel.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class MapViewModel: MapViewInput {
    var controller: MapViewOutput?
    
    func interfaceDidLoad() {
        updateAnnotation()
    }
    
    func updateAnnotation() {
        Network.getAllCountries(completionHandler: { (coronavirus) in
            self.controller?.didUpdateCoronavirus(infoCoronavirus: coronavirus)
        }) {
            // ERROR HANDLER
        }
    }
    
}
