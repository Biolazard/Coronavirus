//
//  Network.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire

class Network {

//    api key news 01a0796a70534344b2311a0baf2150c1
    
    class func getImage(url: URL, completionHandler: @escaping (UIImage) -> Void) {
        AF.request(url).response { response in
            guard response.error == nil else { return }
            if let data = response.data {
                if let image = UIImage(data: data) {
                    completionHandler(image)
                }
            }
        }
    }
    
    class func getNews(completionHandler: @escaping (News) -> Void) {
        let parameters: Parameters = [
            "q": "Coronavirus",
            "apiKey": "01a0796a70534344b2311a0baf2150c1",
            "country": "\(Locale.current.regionCode?.lowercased() ?? "us")"
        ]
        
        AF.request(URL(string: "https://newsapi.org/v2/top-headlines")!, parameters: parameters)
        .response { response in
            guard response.error == nil else { return }
            if let data = response.data {
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    completionHandler(news)
                } catch { debugPrint("ERROR DOWNLOAD NEWS \(error)") }
            }
        }
    }
    
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
