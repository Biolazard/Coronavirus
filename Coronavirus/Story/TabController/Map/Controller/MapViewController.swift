//
//  MapViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    @IBOutlet weak var googleMapsView: GoogleMapsView?
    
    var mapModel: MapViewInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapModel?.interfaceDidLoad()
    }
}

extension MapViewController: MapViewOutput {
    func didUpdateCoronavirus(infoCoronavirus: [Coronavirus]) {
        googleMapsView?.setAnnotation(infoCoronavirus)
    }

}
