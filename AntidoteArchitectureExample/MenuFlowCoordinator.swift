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
        let navVC = UINavigationController(rootViewController: viewController)

        viewController.selectMasterDetailHandler = showMasterDetail(withViewController: viewController, animated: animated)
        viewController.selectPageBasedHandler = showPageBased(withViewController: viewController, animated: animated)
        viewController.selectTabbedHandler = showTabbed(withViewController: viewController, animated: animated)
        viewController.selectModalHandler = showModal(withViewController: viewController, animated: animated)
        viewController.selectPushHandler = showPush(withNavigationController: navVC, animated: animated)
        viewController.selectContainerHandler = showContainer(withViewController: viewController, animated: animated)
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
        window.setRootViewController(navVC, animated: animated)
        self.navigationController = navVC
    }
    
    func showMasterDetail(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = {
            let masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: viewController)
            masterDetailFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(masterDetailFlowCoordinator)
            }
            masterDetailFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(masterDetailFlowCoordinator)
        }
        return handler
    }
    
    func showPageBased(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = {
            let pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: viewController)
            pageBasedFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(pageBasedFlowCoordinator)
            }
            pageBasedFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(pageBasedFlowCoordinator)
        }
        return handler
    }
    
    func showTabbed(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = {
            let tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: viewController)
            tabbedFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(tabbedFlowCoordinator)
            }
            tabbedFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(tabbedFlowCoordinator)
        }
        return handler
    }
    
    func showModal(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = {
            let userFlowCoordinator = UserFlowCoordinator(presentingViewController: viewController)
            userFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        return handler
    }
    
    func showPush(withNavigationController navigationController: UINavigationController, animated: Bool) -> (() -> ()) {
        let handler = {
            let userFlowCoordinator = UserFlowCoordinator(presentingNavigationController: navigationController)
            userFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        return handler
    }
    
    func showContainer(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = {
            let userFlowCoordinator = UserFlowCoordinator(presentingViewController: viewController)
            userFlowCoordinator.closeHandler = {
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        return handler
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