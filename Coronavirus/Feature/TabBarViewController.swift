//
//  TabBarViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.children.forEach({ (vc) in
            if let nav = vc as? UINavigationController, let map = nav.topViewController as? WorldSpreadController {
                map.dataManager = dataManager
                map.model = WorldSpreadVM()
            }
            if let nav = vc as? UINavigationController, let table = nav.topViewController as? ListController {
                table.dataManager = dataManager
                table.model = ListControllerVM()
            }
        })
    }
    
}
