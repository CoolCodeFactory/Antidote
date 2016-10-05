//
//  MenuFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MenuFlowCoordinator: RootCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = MenuViewControllersFactory()
        
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated: Bool) {
        let viewController = viewControllersFactory.menuTableViewController()
        let navigationController = NavigationViewController(rootViewController: viewController)
        
        viewController.selectMasterDetailHandler = { [unowned self] in
            let masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: navigationController)
            self.addChildCoordinator(masterDetailFlowCoordinator)
            masterDetailFlowCoordinator.closeHandler = { [unowned masterDetailFlowCoordinator] in
                masterDetailFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(masterDetailFlowCoordinator)
            }
            masterDetailFlowCoordinator.start(animated: animated)
        }
        viewController.selectPageBasedHandler = { [unowned self] in
            let pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: navigationController)
            self.addChildCoordinator(pageBasedFlowCoordinator)
            pageBasedFlowCoordinator.closeHandler = { [unowned pageBasedFlowCoordinator] in
                pageBasedFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(pageBasedFlowCoordinator)
            }
            pageBasedFlowCoordinator.start(animated: animated)
        }
        viewController.selectTabbedHandler = { [unowned self] in
            let tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: navigationController)
            self.addChildCoordinator(tabbedFlowCoordinator)
            tabbedFlowCoordinator.closeHandler = { [unowned tabbedFlowCoordinator] in
                tabbedFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(tabbedFlowCoordinator)
            }
            tabbedFlowCoordinator.start(animated: animated)
        }
        viewController.selectModalHandler = { [unowned self] in
            let userModalFlowCoordinator = UserModalFlowCoordinator(presentingViewController: navigationController)
            self.addChildCoordinator(userModalFlowCoordinator)
            userModalFlowCoordinator.closeHandler = { [unowned self] in
                userModalFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(userModalFlowCoordinator)
            }
            userModalFlowCoordinator.start(animated: animated)
        }
        viewController.selectPushHandler = { [unowned self] in
            let userFlowCoordinator = UserNavigationFlowCoordinator(presentingNavigationController: navigationController)
            self.addChildCoordinator(userFlowCoordinator)
            userFlowCoordinator.closeHandler = { [unowned userFlowCoordinator] in
                userFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
        }
        viewController.selectContainerHandler = { [unowned self] in
            let userContainerFlowCoordinator = UserContainerFlowCoordinator(presentingViewController: navigationController)
            self.addChildCoordinator(userContainerFlowCoordinator)
            userContainerFlowCoordinator.closeHandler = { [unowned userContainerFlowCoordinator] in
                userContainerFlowCoordinator.finish(animated: animated)
                self.removeChildCoordinator(userContainerFlowCoordinator)
            }
            userContainerFlowCoordinator.start(animated: animated)
        }
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        window.setRootViewController(navigationController, animated: animated)
        self.navigationController = navigationController
    }
    
    func finish(animated: Bool) {
        removeAllChildCoordinators()
    }
    
    
    deinit {
        print("Deinit: \(self)")
    }
    
    @objc func end(_ sender: UIBarButtonItem) {
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
