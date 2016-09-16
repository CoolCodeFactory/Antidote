//
//  MenuFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MenuFlowCoordinator: RootCoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    weak var navigationController: UINavigationController?
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = MenuViewControllersFactory()
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.menuTableViewController()
        viewController.selectMasterDetailHandler = {
            let masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: viewController)
            masterDetailFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(masterDetailFlowCoordinator)
            }
            masterDetailFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(masterDetailFlowCoordinator)
        }
        viewController.selectPageBasedHandler = {
            let pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: viewController)
            pageBasedFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(pageBasedFlowCoordinator)
            }
            pageBasedFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(pageBasedFlowCoordinator)
        }
        viewController.selectTabbedHandler = {
            let tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: viewController)
            tabbedFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(tabbedFlowCoordinator)
            }
            tabbedFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(tabbedFlowCoordinator)
        }
        viewController.selectModalHandler = {
            let userFlowCoordinator = UserFlowCoordinator(presentingViewController: viewController)
            userFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        let navVC = UINavigationController(rootViewController: viewController)
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
        window.setRootViewController(navVC, animated: animated)
    }
    
    @objc func end(sender: UIBarButtonItem) {
        closeHandler()
    }
}

extension MenuFlowCoordinator {
    
    func presentMasterDatailFlow() {
        
    }
    
    func presentPageBasedFlow() {
        
    }
    
    func presentTabbedFlow() {
        
    }
}