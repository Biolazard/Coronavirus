//
//  RegioneViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 21/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class RegioneViewController: UIViewController {
    
    
    @IBOutlet weak var totaleOspedalizzati: UILabel!
    @IBOutlet weak var terapiaIntensiva: UILabel!
    @IBOutlet weak var isolamentoDomiciliare: UILabel!
    @IBOutlet weak var totalePositivi: UILabel!
    @IBOutlet weak var guariti: UILabel!
    @IBOutlet weak var deceduti: UILabel!
    @IBOutlet weak var casiTotali: UILabel!
    @IBOutlet weak var tamponi: UILabel!
    
    
    var data: Italy!
    @IBOutlet weak var containerInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       

        
        totaleOspedalizzati.text = "\(data.totaleOspedalizzati)"
        terapiaIntensiva.text = "\(data.terapiaIntensiva)"
        isolamentoDomiciliare.text = "\(data.isolamentoDomiciliare)"
        totalePositivi.text = "\(data.totalePositivi)"
        guariti.text = "\(data.guariti)"
        deceduti.text = "\(data.deceduti)"
        casiTotali.text = "\(data.casiTotali)"
        tamponi.text = "\(data.tamponi)"
    }

}
