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
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.changeMapStyle()
        model.updateAnnotation(covid: dataManager.coronavirus)
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.delegate = self
    }
    
    @IBAction func reloadAnnotation(_ sender: UIButton) {
        model.showLoading()
        self.dataManager.refreshData()
        
        UIButton.animate(withDuration: 1.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.refreshButton.transform = self.refreshButton.transform.rotated(by: CGFloat(Double.pi))
        }, completion: nil)
        
        

    }
    
    func didUpdateData() {
        model.updateAnnotation(covid: dataManager.coronavirus)
    }
    
    private func configureButton() {
        refreshButton.layer.cornerRadius = refreshButton.frame.height / 2
    }
}

