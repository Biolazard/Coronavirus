//
//  ViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {

    
    @IBOutlet weak var map: MKMapView!
    
    let coreData = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addAnnotation(covid: coreData.getDataSpread())
    }
    
    func addAnnotation(covid: [Covid19]) {
        for c in covid {
            let annotation = MKPointAnnotation()
            annotation.title = c.country
            annotation.coordinate = CLLocationCoordinate2D(latitude: c.latitude, longitude: c.longitude)
            DispatchQueue.main.async {
                self.map.addAnnotation(annotation)
            }
        }
    }
    
    
}

