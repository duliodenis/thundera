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
        
        let thunderPurple = UIColor(red: 85.0/255, green: 37.0/255, blue: 131.0/255, alpha: 1.0)
        
        view.backgroundColor = thunderPurple
        tabBar.tintColor = thunderPurple
        
        setupViewControllers()
    }
    
    
    // MARK: - Setup Method
    
    fileprivate func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(for: ViewController(), title: "Search", image: #imageLiteral(resourceName: "search")),
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
