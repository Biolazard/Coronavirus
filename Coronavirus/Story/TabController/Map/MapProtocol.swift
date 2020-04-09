//
//  MapProtocol.swift
//  Coronavirus
//
//  Created by Marius Lazar on 09/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

protocol MapInput: BaseActionInput {
    func updateMarker()
}

protocol MapOutput {
    func didUpdateMarker()
}
