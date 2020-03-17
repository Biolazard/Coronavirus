//
//  ViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 26/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import GoogleMaps

class WorldSpreadController: UIViewController, CoronavirusDelegate {
    
    
    @IBOutlet weak var map: GMSMapView!
    
    var model: WorldSpreadVM!
    var dataManager: DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.changeMapStyle()
        model.updateAnnotation(covid: dataManager.coronavirus)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.delegate = self
    }

    @IBAction func reloadAboutCoronavirus(_ sender: UIBarButtonItem) {
        model.showLoading()
        self.dataManager.refreshData()
    }
    
    func didUpdateData() {
        model.updateAnnotation(covid: dataManager.coronavirus)
    }
}

