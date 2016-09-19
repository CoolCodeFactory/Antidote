//
//  UserViewControllersFactory.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class UserViewControllersFactory {
    
    let storyboard = UIStoryboard(name: "User", bundle: nil)
    
    
    func navigationController() -> NavigationViewController {
        let viewController = NavigationViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
    
    func usersTableViewController() -> UsersTableViewController {
        let viewController = UsersTableViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
    
    func userViewController(withName name: String) -> UserViewController {
        let viewController = UserViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        viewController.name = name
        
        return viewController
    }
}