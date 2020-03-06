//
//  News.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

struct News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    var source: Source
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    
}

struct Source: Codable {
    var name: String
}
