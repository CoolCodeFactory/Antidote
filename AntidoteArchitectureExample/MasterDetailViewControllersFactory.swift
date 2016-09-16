//
//  MasterDetailViewControllersFactory.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class MasterDetailViewControllersFactory {
    
    let storyboard = UIStoryboard(name: "MasterDetail", bundle: nil)
    
    
    func masterDetailViewController() -> MasterDetailViewController {
        let viewController = MasterDetailViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
}