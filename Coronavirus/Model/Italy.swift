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
    var numeroInfetti: String
    var terapiaIntensiva: String
    var isolamentoDomiciliare: String
    var totalePositivi: String
    var guariti: String
    var deceduti: String
    var casiTotali: String
    var tamponi: String
    var data: String
    var aggiornamento: String
    var fonte: String
    
    enum CodingKeys: String, CodingKey {
        case regione, guariti, deceduti, tamponi, data, aggiornamento, fonte
        case numeroInfetti = "numero infetti"
        case terapiaIntensiva = "terapia intensiva"
        case isolamentoDomiciliare = "isolamento domiciliare"
        case totalePositivi = "totale positivi"
        case casiTotali = "casi totali"
        
    }
}


//"regione": "Lombardia",
//"numero infetti": "1622",
//"terapia intensiva": "309",
//"isolamento domiciliare": "77",
//"totale positivi": "2008",
//"guariti": "469",
//"deceduti": "135",
//"casi totali": "2612",
//"tamponi": "13556",
//"data": "2020-03-06",
//"aggiornamento": "pomeridiano",
//"fonte":
