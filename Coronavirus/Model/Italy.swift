//
//  Italy.swift
//  Coronavirus
//
//  Created by Marius Lazar on 21/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

struct Italy: Codable {
    var regione: String
    var totaleOspedalizzati: Int
    var terapiaIntensiva: Int
    var isolamentoDomiciliare: Int
    var totalePositivi: Int
    var guariti: Int
    var deceduti: Int
    var casiTotali: Int
    var tamponi: Int

    
    enum CodingKeys: String, CodingKey {
        case regione, deceduti, tamponi
        case guariti = "dimessi guariti"
        case totaleOspedalizzati = "totale ospedalizzati"
        case terapiaIntensiva = "terapia intensiva"
        case isolamentoDomiciliare = "isolamento domiciliare"
        case totalePositivi = "totale attualmente positivi"
        case casiTotali = "totale casi"
        
    }
}


//"ricoverati con sintomi": 206,
//"nuovi attualmente positivi": 79,




