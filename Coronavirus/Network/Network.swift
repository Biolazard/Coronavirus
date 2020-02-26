//
//  Network.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

class Network {
    
    private enum DataError: Error {
        case invalidResponse, invalidData, decodingError, serverError
    }
    
    class func genericDownload(url: URL, completion: @escaping ([Covid]) -> Void) {
        
        var regionsInfected = [Covid]()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            if let data = data, var responseString = String(data: data, encoding: .utf8) {
                responseString = responseString.replacingOccurrences(of: "\"", with: "")
                let lines = responseString.split(separator: "\n")
                for line in lines.dropFirst() {
                    var line = line
                    if line.first == "," {
                        line.removeFirst()
                    }
                    let row = line.split(separator: ",")
                    var country = ""
                    if row.count == 7 {
                        country = "\(row[0]) \(row[1])"
                    } else  {
                        country = "\(row[0])"
                    }
                    
                    let lastUpdate = String(row[row.count - 4])
                    let confimerd = String(row[row.count - 3])
                    let deaths = String(row[row.count - 2])
                    let recovered = String(row[row.count - 1])
                    
                    let region = Covid(country: country, lastUpdate: lastUpdate, confirmed: confimerd, deaths: deaths, recovered: recovered)
                    regionsInfected.append(region)
                }
                completion(regionsInfected)
            }
        }.resume()
    }
    
    class func downloadList<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200...299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodeData: [T] = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(decodeData))
                    } catch {
                        completion(.failure(DataError.decodingError))
                        
                    }
                    
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
        }.resume()
        
    }
}
