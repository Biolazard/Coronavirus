//
//  MapProtocols.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import GoogleMaps

protocol MapViewInput: BaseViewInput {
    var controller: MapViewOutput? { get set }
    
    func updateAnnotation()
}

protocol MapViewOutput {
    func didUpdateCoronavirus(infoCoronavirus: [Coronavirus])
}

protocol GoogleMapsProtocol: class {
    func setAnnotation(_ infoCoronavirus: [Coronavirus])
}

