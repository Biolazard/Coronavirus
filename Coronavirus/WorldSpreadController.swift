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
//        dataManager.refreshData()
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
    
    func showData(data: [Covid19]) {
        addAnnotation(covid: data)
    }
}

