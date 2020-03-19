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
    private var alert = Activity(title: nil, message: nil, preferredStyle: .alert)
    
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
}

extension WorldSpreadVM {
    func getCustomMap() -> String {
    
        String()
    }
}
