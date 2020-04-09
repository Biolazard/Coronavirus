//
//  BaseProtocol.swift
//  Coronavirus
//
//  Created by Marius Lazar on 07/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

protocol TabGetableProp {
    var coronavirus: [Coronavirus] { get set }
}

protocol BaseActionInput: class {
    var tabController: BaseActionOutput? { get set }
    
    func updateData()
}

protocol BaseActionOutput: class {
    func didUpdate(covid19: [Coronavirus])
}

protocol CovidProtocol: class {
    var coronavirus: [Coronavirus] { get set }
}
