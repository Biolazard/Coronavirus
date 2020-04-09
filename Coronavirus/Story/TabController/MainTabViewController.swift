//
//  MainTabViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController{
    
    private var model: BaseActionInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        setViewControllers(configureViewControllers(), animated: true)
    }
    
    private func configureModel() {
        model = TabBarModel()
        model?.tabController = self
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
                v.model = MapModel()
                v.model?.tabController = self
                
            
            case is CovidTableViewController:

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

extension MainTabViewController: BaseActionOutput {
    func didUpdate(covid19: [Coronavirus]) {
        if let n = selectedViewController as? UINavigationController, let v = n.viewControllers.first as? CovidProtocol{
            v.coronavirus = covid19
        }
    }
    
}
