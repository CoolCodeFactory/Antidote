//
//  AuthenticationViewControllersFactory.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class AuthenticationViewControllersFactory {
    
    var storyboard: UIStoryboard = {
        UIStoryboard(name: "Authentication", bundle: nil)
    }()
    
    
    func signInViewController() -> SignInViewController {
        let viewController = SignInViewController.controllerFromStoryboard(storyboard)
        
        // Configure ViewController
        
        return viewController
    }
}