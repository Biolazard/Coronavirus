//
//  Network.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import CoreLocation

class Network {

    
    class func genericDownload(url: URL, completion: @escaping ([Covid]) -> Void, handleError: @escaping (Error) -> Void) {
        
        var regionsInfected = [Covid]()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                handleError(error)
            }
            if let data = data, var responseString = String(data: data, encoding: .utf8) {
                responseString = responseString.replacingOccurrences(of: "\"", with: "")
                let lines = responseString.split(separator: "\n")
                for line in lines.dropFirst() {
                    var line = line
                    if line.first == "," {
                        line.removeFirst()
                    }
                    let row = line.split(separator: ",")
                    
                    let country = String(row.first ?? "")
                    let lastUpdate = String(row[row.count - 6])
                    let confimerd = String(row[row.count - 5])
                    let deaths = String(row[row.count - 4])
                    let recovered = String(row[row.count - 3])
                    let coordinates = CLLocationCoordinate2D(latitude: Double(row[row.count - 2])!, longitude: Double(row[row.count - 1])!)
                    
                    let infects = Covid(country: country, lastUpdate: lastUpdate, confirmed: confimerd, deaths: deaths, recovered: recovered, coordinates: coordinates)
                    regionsInfected.append(infects)
                }
                debugPrint("REQUEST URL \(url)")
                DispatchQueue.main.sync {
                    completion(regionsInfected)
                }
                
            }
        }.resume()
    }
    
}
