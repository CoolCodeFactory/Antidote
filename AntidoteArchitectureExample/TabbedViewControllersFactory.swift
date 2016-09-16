//
//  TabbedViewControllersFactory.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class TabbedViewControllersFactory {
    
    let storyboard = UIStoryboard(name: "Tabbed", bundle: nil)
    
    
    func tabbedController() -> TabbedController {
        let viewController = TabbedController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
}
