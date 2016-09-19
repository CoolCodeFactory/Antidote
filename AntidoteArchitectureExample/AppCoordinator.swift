//
//  AppCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class AppCoordinator {
    
    weak var window: UIWindow!
    
    let menuFlowCoordinator: MenuFlowCoordinator
    let authenticationFlowCoordinator: AuthenticationFlowCoordinator
    
    private var isAuthenticated = true
    
    required init(window: UIWindow) {
        self.window = window
        menuFlowCoordinator = MenuFlowCoordinator(window: window)
        authenticationFlowCoordinator = AuthenticationFlowCoordinator(window: window)
    }
    
    func start(animated animated: Bool) {
        if authenticated() {
            menuFlowCoordinator.closeHandler = { [unowned self] in
                self.start(animated: animated)
            }
            menuFlowCoordinator.start(animated: animated)
        } else {
            authenticationFlowCoordinator.closeHandler = { [unowned self] in
                self.start(animated: animated)
            }
            authenticationFlowCoordinator.start(animated: animated)
        }
    }
}

extension AppCoordinator {
    
    func authenticated() -> Bool {
        isAuthenticated = !isAuthenticated
        return isAuthenticated
    }
}