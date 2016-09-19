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
    
    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = MenuViewControllersFactory()
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.menuTableViewController()
        let navVC = NavigationViewController(rootViewController: viewController)

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
    
    
    deinit {
        print("Deinit: \(self)")
    }
    
    func showMasterDetail(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self, unowned viewController] in
            let masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: viewController)
            masterDetailFlowCoordinator.closeHandler = { [unowned self, unowned masterDetailFlowCoordinator] in
                self.removeChildCoordinator(masterDetailFlowCoordinator)
            }
            masterDetailFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(masterDetailFlowCoordinator)
        }
        return handler
    }
    
    func showPageBased(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self, unowned viewController] in
            let pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: viewController)
            pageBasedFlowCoordinator.closeHandler = { [unowned self, unowned pageBasedFlowCoordinator] in
                self.removeChildCoordinator(pageBasedFlowCoordinator)
            }
            pageBasedFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(pageBasedFlowCoordinator)
        }
        return handler
    }
    
    func showTabbed(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self, unowned viewController] in
            let tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: viewController)
            tabbedFlowCoordinator.closeHandler = { [unowned self, unowned tabbedFlowCoordinator] in
                self.removeChildCoordinator(tabbedFlowCoordinator)
            }
            tabbedFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(tabbedFlowCoordinator)
        }
        return handler
    }
    
    func showModal(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self, unowned viewController] in
            let userFlowCoordinator = UserFlowCoordinator(presentingViewController: viewController)
            userFlowCoordinator.closeHandler = { [unowned self, unowned userFlowCoordinator] in
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        return handler
    }
    
    func showPush(withNavigationController navigationController: NavigationViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self, unowned navigationController] in
            let userFlowCoordinator = UserFlowCoordinator(presentingNavigationController: navigationController)
            userFlowCoordinator.closeHandler = { [unowned self, unowned userFlowCoordinator] in
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        return handler
    }
    
    func showContainer(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self, unowned viewController] in
            let userFlowCoordinator = UserFlowCoordinator(presentingViewController: viewController)
            userFlowCoordinator.closeHandler = { [unowned self, unowned userFlowCoordinator] in
                self.removeChildCoordinator(userFlowCoordinator)
            }
            userFlowCoordinator.start(animated: animated)
            self.addChildCoordinator(userFlowCoordinator)
        }
        return handler
    }
    
    @objc func end(sender: UIBarButtonItem) {
        removeAllChildCoordinators()
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
