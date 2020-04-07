//
//  MainTabViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

enum StoryboardList: String {
    case main = "Main"
    case table = "Table"
    case tab = "Tab"
    case map = "Map"
}

enum StoryboardIdentifier: String {
    case MapViewController, CovidTableViewController
}

class MainTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        setViewControllers(configureViewControllers(), animated: true)
    }
}

extension MainTabViewController: TabConfigurationProtocol {
    func configureViewControllers() -> [UIViewController] {
        var controllers = [UIViewController]()
        controllers.append(createTabBarItem(storyboard: .map, identifier: .MapViewController, title: "Mappa", image: UIImage(systemName: "circle")!))
        controllers.append(createTabBarItem(storyboard: .table, identifier: .CovidTableViewController, title: "Tabella", image: UIImage(systemName: "circle")!))
            
        return controllers
    }
    
    func createTabBarItem(storyboard: StoryboardList, identifier: StoryboardIdentifier, title: String, image: UIImage, hasNavigation: Bool = true) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(identifier: identifier.rawValue)
        
        switch viewController {
            case is MapViewController:
                let v = viewController as! MapViewController
                v.mapModel = MapViewModel()
                (v.mapModel as? MapViewModel)?.controller = v
            
            case is CovidTableViewController:
//                let v = viewController as! CovidTableViewController
                
                break
            default:
                break
        }
        
        viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        
        if hasNavigation {
            return UINavigationController(rootViewController: viewController)
        }
        
        return viewController
    }
}
