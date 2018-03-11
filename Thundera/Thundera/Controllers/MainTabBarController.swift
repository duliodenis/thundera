//
//  MainTabBarController.swift
//  Thundera
//
//  Created by Dulio Denis on 3/9/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().prefersLargeTitles = true
        
        view.backgroundColor = UIColor.purpleThunder
        tabBar.tintColor = UIColor.purpleThunder
        
        setupViewControllers()
    }
    
    
    // MARK: - Setup Method
    
    fileprivate func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: SearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(for: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    
    // MARK: - Helper Method
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController,
                                                  title: String,
                                                  image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        rootViewController.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
}
