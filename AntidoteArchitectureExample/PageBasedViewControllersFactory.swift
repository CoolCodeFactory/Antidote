//
//  PageBasedViewControllersFactory.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class PageBasedViewControllersFactory {
    
    let storyboard = UIStoryboard(name: "PageBased", bundle: nil)
    
    
    func pageBasedViewController() -> PageBasedViewController {
        let viewController = PageBasedViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
}