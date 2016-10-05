//
//  AppCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class AppCoordinator: BaseCoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []

    var closeHandler: () -> () = { }

    weak var window: UIWindow!
    
    fileprivate var isAuthenticated = true
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated: Bool) {
        closeHandler = {
            self.finish(animated: animated)
        }
        
        if authenticated() {
            let menuFlowCoordinator = MenuFlowCoordinator(window: window)
            addChildCoordinator(menuFlowCoordinator)
            menuFlowCoordinator.closeHandler = { [unowned menuFlowCoordinator] in
                menuFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(menuFlowCoordinator)
                self.closeHandler()
            }
            menuFlowCoordinator.start(animated: animated)
        } else {
            let authenticationFlowCoordinator = AuthenticationFlowCoordinator(window: window)
            addChildCoordinator(authenticationFlowCoordinator)
            authenticationFlowCoordinator.closeHandler = { [unowned authenticationFlowCoordinator] in
                authenticationFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(authenticationFlowCoordinator)
                self.closeHandler()
            }
            authenticationFlowCoordinator.start(animated: animated)
        }
    }
    
    func finish(animated: Bool) {
        self.removeAllChildCoordinators()
        start(animated: animated)
    }
}

extension AppCoordinator {
    
    func authenticated() -> Bool {
        isAuthenticated = !isAuthenticated
        return isAuthenticated
    }
}
