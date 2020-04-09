//
//  MapViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CovidProtocol {
    
    @IBOutlet weak var googleMapsView: GoogleMapsView?
    
    var coronavirus = [Coronavirus]() {
        didSet {
            googleMapsView?.setMarker(coronavirus)
        }
    }
    
    var model: BaseActionInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.updateData()
    }
    
}

