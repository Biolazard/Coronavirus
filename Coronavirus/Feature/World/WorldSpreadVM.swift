//
//  WorldSpreadVM.swift
//  Coronavirus
//
//  Created by Marius Lazar on 16/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import GoogleMaps

class WorldSpreadVM {
    
    var customMap: String { return getCustomMap() }
    var delegate: WorldSpreadController!
    private var alert: UIAlertController!
    
    init() {
        self.alert = Activity(title: nil, message: nil, preferredStyle: .alert)
    }
    
    //TODO: mettere un throw
    func changeMapStyle() {
        do {
            delegate.map.mapStyle = try GMSMapStyle(jsonString: customMap)
        } catch {}
    }
    
    func updateAnnotation(covid: [Covid19]) {
        hideLoading()
        delegate.map.clear()
        for c in covid {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: c.latitude, longitude: c.longitude)
            marker.title = c.country
            marker.snippet = "Confirmed: \(c.confirmed ?? "")"
            DispatchQueue.main.async {
                marker.map = self.delegate.map
            }
        }
    }
    
    
    func showLoading() {
        delegate.present(alert, animated: true, completion: nil)
    }
    
    func hideLoading() {
        delegate.dismiss(animated: true, completion: nil)
    }
    
    private func initLoadingController() {
        alert = UIAlertController(title: nil, message: "loading...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
    }
}

extension WorldSpreadVM {
    func getCustomMap() -> String {
        """
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
    }
}
