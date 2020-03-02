//
//  DetailViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var data: Covid19!
    
    func injectDependices(data: Covid19) {
        self.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
