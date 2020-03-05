//
//  ViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

let kMapStyle = """
[
{
"elementType": "geometry",
"stylers": [
{
"color": "#f5f5f5"
}
]
},
{
"elementType": "labels.icon",
"stylers": [
{
"visibility": "off"
}
]
},
{
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#616161"
}
]
},
{
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#f5f5f5"
}
]
},
{
"featureType": "administrative.land_parcel",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#bdbdbd"
}
]
},
{
"featureType": "administrative.neighborhood",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "poi",
"elementType": "geometry",
"stylers": [
{
"color": "#eeeeee"
}
]
},
{
"featureType": "poi",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#757575"
}
]
},
{
"featureType": "poi.business",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "poi.park",
"elementType": "geometry",
"stylers": [
{
"color": "#e5e5e5"
}
]
},
{
"featureType": "poi.park",
"elementType": "labels.text",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "poi.park",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#9e9e9e"
}
]
},
{
"featureType": "road",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "road",
"elementType": "geometry",
"stylers": [
{
"color": "#ffffff"
}
]
},
{
"featureType": "road",
"elementType": "labels",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "road.arterial",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#757575"
}
]
},
{
"featureType": "road.highway",
"elementType": "geometry",
"stylers": [
{
"color": "#dadada"
}
]
},
{
"featureType": "road.highway",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#616161"
}
]
},
{
"featureType": "road.local",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#9e9e9e"
}
]
},
{
"featureType": "transit.line",
"elementType": "geometry",
"stylers": [
{
"color": "#e5e5e5"
}
]
},
{
"featureType": "transit.station",
"elementType": "geometry",
"stylers": [
{
"color": "#eeeeee"
}
]
},
{
"featureType": "water",
"elementType": "geometry",
"stylers": [
{
"color": "#c9c9c9"
}
]
},
{
"featureType": "water",
"elementType": "labels.text",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "water",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#9e9e9e"
}
]
}
]
"""


class WorldSpreadController: UIViewController, CoronavirusDelegate {

    
    @IBOutlet weak var map: GMSMapView!
    
    var dataManager: DataManager!
    
    func dependencyInjection(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeMapStyle()
        addAnnotation(covid: dataManager.coronavirus)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.delegate = self
    }

    func addAnnotation(covid: [Covid19]) {
        for c in covid {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: c.latitude, longitude: c.longitude)
            marker.title = c.country
            marker.snippet = "Confirmed: \(c.confirmed ?? "")"
            DispatchQueue.main.async {
                marker.map = self.map
            }
        }
    }
    
    func showData() {
        self.navigationItem.title = "Confirmed cases"
        map.clear()
        addAnnotation(covid: dataManager.coronavirus)
    }
    
    func changeMapStyle() {
        do {
            map.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
        } catch {}
    }
    
    @IBAction func reloadAboutCoronavirus(_ sender: UIBarButtonItem) {
        self.navigationItem.title = "Downloading..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataManager.refreshData()
        }
    }
}

