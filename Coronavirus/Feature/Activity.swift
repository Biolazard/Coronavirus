//
//  Activity.swift
//  Coronavirus
//
//  Created by Marius Lazar on 16/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class Activity: UIAlertController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.message = "Loading..."
           let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
           loadingIndicator.hidesWhenStopped = true
           loadingIndicator.style = UIActivityIndicatorView.Style.medium
           loadingIndicator.startAnimating();
        self.view.addSubview(loadingIndicator)
    }
}
