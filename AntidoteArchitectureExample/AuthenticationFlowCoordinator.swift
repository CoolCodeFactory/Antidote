//
//  AuthenticationFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class AuthenticationFlowCoordinator: RootCoordinatorProtocol {
        
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = AuthenticationViewControllersFactory()
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    deinit {
        print("Deinit: \(self)")
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.signInViewController()
        viewController.signInHandler = { [unowned self] in
            self.finish(animated: animated)
        }
        window.setRootViewController(viewController, animated: animated)
    }
    
    func finish(animated animated: Bool) {
        closeHandler()
    }
}
