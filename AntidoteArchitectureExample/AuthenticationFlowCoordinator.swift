//
//  AuthenticationFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class AuthenticationFlowCoordinator: RootCoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    weak var navigationController: UINavigationController?
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = AuthenticationViewControllersFactory()
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.signInViewController()
        viewController.signInHandler = {
            self.closeHandler()
        }
        window.setRootViewController(viewController, animated: animated)
    }
}
