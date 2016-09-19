//
//  AppCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class AppCoordinator: RootCoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    weak var navigationController: NavigationViewController?

    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    private var isAuthenticated = true
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated animated: Bool) {
        if authenticated() {
            let menuFlowCoordinator = MenuFlowCoordinator(window: window)
            menuFlowCoordinator.closeHandler = { [unowned self, unowned menuFlowCoordinator] in
                self.removeChildCoordinator(menuFlowCoordinator)
                self.start(animated: animated)
            }
            menuFlowCoordinator.start(animated: animated)
            addChildCoordinator(menuFlowCoordinator)
        } else {
            let authenticationFlowCoordinator = AuthenticationFlowCoordinator(window: window)
            authenticationFlowCoordinator.closeHandler = { [unowned self, unowned authenticationFlowCoordinator] in
                self.removeChildCoordinator(authenticationFlowCoordinator)
                self.start(animated: animated)
            }
            authenticationFlowCoordinator.start(animated: animated)
            addChildCoordinator(authenticationFlowCoordinator)
        }
    }
}

extension AppCoordinator {
    
    func authenticated() -> Bool {
        isAuthenticated = !isAuthenticated
        return isAuthenticated
    }
}