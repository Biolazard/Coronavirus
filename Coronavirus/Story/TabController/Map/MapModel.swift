//
//  MapModel.swift
//  Coronavirus
//
//  Created by Marius Lazar on 09/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

class MapModel: BaseActionInput {
    var tabController: BaseActionOutput?
    
    func updateData() {
        Network.getAllCountries(completionHandler: { (coronavirus) in
            self.tabController?.didUpdate(covid19: coronavirus)
        }) { (error) in
            debugPrint(error)
        }
    }
    
}
