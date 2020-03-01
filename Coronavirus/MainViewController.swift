//
//  ViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addAnnotation(covid: [Covid]) {
        for c in covid {
            let annotation = MKPointAnnotation()
            annotation.title = c.country
            annotation.coordinate = c.coordinates
            DispatchQueue.main.async {
                self.map.addAnnotation(annotation)
            }
        }
    }
    
    
}

