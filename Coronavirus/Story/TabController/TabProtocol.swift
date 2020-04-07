//
//  TabProtocol.swift
//  Coronavirus
//
//  Created by Marius Lazar on 07/04/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

protocol TabConfigurationProtocol: class {
    func configureViewControllers() -> [UIViewController]
    func createTabBarItem(storyboard: StoryboardList, identifier: StoryboardIdentifier, title: String, image: UIImage, hasNavigation: Bool) -> UIViewController
}
