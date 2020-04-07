//
//  Network.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    static func getAllCountries(completionHandler: @escaping ([Coronavirus]) -> Void, errorHandler: @escaping () -> Void) {
        let url = URL(string: "https://covid-19-data.p.rapidapi.com/country/all?format=undefined")!
        
        let headers: HTTPHeaders = [
          "x-rapidapi-key": "8b666de372msha1a0fdfe6f65fc1p1eee56jsn0f1382dabb50"
        ]
        
        AF.request(url, headers: headers).responseJSON { (data) in
            if let data = data.data {
                do {
                    let coronavirus = try JSONDecoder().decode([Coronavirus].self, from: data)
                    completionHandler(coronavirus)
                } catch {
                    errorHandler()
                }
            }
        }
        
    }
      
}
