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
    
    var errorCountry = [String]() {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let first = self.errorCountry.first {
                    self.errorCountry.removeFirst()
                    self.addAnnotation(country: first, title: first)
                }
                print(self.errorCountry)
            }
        }
    }
    
    var errorPerCountry = [String: Int]()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.genericDownload(url: URL(string: "https://raw.githubusercontent.com/JustMek/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-25-2020.csv")!) { (response) in
            for c in response {
                self.addAnnotation(country: c.country, title: c.country)
            }
        }
    }
    
    func addAnnotation(country: String, title: String) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        let geoCoder = CLGeocoder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            geoCoder.geocodeAddressString(country) { (placemarks, error) in
                guard error == nil else {
                    self.findRipetitionError(of: country)
                    return
                }
                if let location = placemarks?.first?.location {
                    annotation.coordinate = location.coordinate
                    self.map.addAnnotation(annotation)
                }
            }
        }
        
    }
    
    func findRipetitionError(of country: String) {
        errorCountry.append(country)
        if let errorCount = self.errorPerCountry[country] {
            if errorCount > 20 {
                errorCountry.removeLast()
                errorPerCountry.removeValue(forKey: country)
            } else {
                errorPerCountry[country] = errorCount + 1
            }
        } else {
            errorPerCountry[country] = 0
        }
    }


}

