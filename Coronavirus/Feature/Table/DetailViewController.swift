//
//  DetailViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var covid: Covid19!
    
    @IBOutlet weak var viewConfirmed: UIView!
    @IBOutlet weak var viewRecovered: UIView!
    @IBOutlet weak var viewDeath: UIView!
    
    @IBOutlet weak var numberConfirmed: UILabel!
    @IBOutlet weak var numberRecovered: UILabel!
    @IBOutlet weak var numberDeath: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        numberConfirmed.text = covid.confirmed
        numberRecovered.text = covid.recovered
        numberDeath.text = covid.deaths
        title = covid.country
    }
    
    private func configureLayout() {
        let radius: CGFloat = viewConfirmed.frame.height / 8
        viewConfirmed.layer.cornerRadius = radius
        viewRecovered.layer.cornerRadius = radius
        viewDeath.layer.cornerRadius = radius
        
    }


}
