//
//  MenuViewControllersFactory.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class MenuViewControllersFactory {
    
    var storyboard: UIStoryboard = {
        UIStoryboard(name: "Menu", bundle: nil)
    }()
    
    func menuTableViewController() -> MenuTableViewController {
        let viewController = MenuTableViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
}