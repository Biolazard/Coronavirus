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

class WorldSpreadController: UIViewController, CoronavirusDelegate {

    
    @IBOutlet weak var map: MKMapView!
    
    var dataManager: DataManager!
    
    func dependencyInjection(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        addAnnotation(covid: dataManager.coronavirus)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func addAnnotation(covid: [Covid19]) {
        for c in covid {
            let annotation = MKPointAnnotation()
            annotation.title = "Confirmed \(c.confirmed ?? "")"
            annotation.subtitle = c.country
            annotation.coordinate = CLLocationCoordinate2D(latitude: c.latitude, longitude: c.longitude)
            DispatchQueue.main.async {
                self.map.addAnnotation(annotation)
            }
        }
    }
    
    func showData() {
        map.removeAnnotations(map.annotations)
        addAnnotation(covid: dataManager.coronavirus)
    }
}

