//
//  MenuFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MenuFlowCoordinator: RootCoordinatorProtocol {
    
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = MenuViewControllersFactory()
    
    var masterDetailFlowCoordinator: MasterDetailFlowCoordinator!
    var pageBasedFlowCoordinator: PageBasedFlowCoordinator!
    var tabbedFlowCoordinator: TabbedFlowCoordinator!
    var userFlowCoordinator: UserFlowCoordinator!
    var userModalFlowCoordinator: UserFlowCoordinator!
    var userContainerFlowCoordinator: UserContainerFlowCoordinator!
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start(animated: Bool) {
        let viewController = viewControllersFactory.menuTableViewController()
        let navigationController = NavigationViewController(rootViewController: viewController)
        
        masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: navigationController)
        pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: navigationController)
        tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: navigationController)
        userModalFlowCoordinator = UserModalFlowCoordinator(presentingViewController: navigationController)
        userFlowCoordinator = UserNavigationFlowCoordinator(presentingNavigationController: navigationController)
        userContainerFlowCoordinator = UserContainerFlowCoordinator(presentingViewController: navigationController)
        
        viewController.selectMasterDetailHandler = { [unowned self] in
            self.masterDetailFlowCoordinator.closeHandler = { [unowned self] in
                self.masterDetailFlowCoordinator.finish(animated: animated)
            }
            self.masterDetailFlowCoordinator.start(animated: animated)
        }
        viewController.selectPageBasedHandler = { [unowned self] in
            self.pageBasedFlowCoordinator.closeHandler = { [unowned self] in
                self.pageBasedFlowCoordinator.finish(animated: animated)
            }
            self.pageBasedFlowCoordinator.start(animated: animated)
        }
        viewController.selectTabbedHandler = { [unowned self] in
            self.tabbedFlowCoordinator.closeHandler = { [unowned self] in
                self.tabbedFlowCoordinator.finish(animated: animated)
            }
            self.tabbedFlowCoordinator.start(animated: animated)
        }
        viewController.selectModalHandler = { [unowned self] in
            self.userModalFlowCoordinator.closeHandler = { [unowned self] in
                self.userModalFlowCoordinator.finish(animated: animated)
            }
            self.userModalFlowCoordinator.start(animated: animated)
        }
        viewController.selectPushHandler = { [unowned self] in
            self.userFlowCoordinator.closeHandler = { [unowned self] in
                self.userFlowCoordinator.finish(animated: animated)
            }
            self.userFlowCoordinator.start(animated: animated)
        }
        viewController.selectContainerHandler = { [unowned self] in
            self.userContainerFlowCoordinator.closeHandler = { [unowned self] in
                self.userContainerFlowCoordinator.finish(animated: animated)
            }
            self.userContainerFlowCoordinator.start(animated: animated)
        }
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        window.setRootViewController(navigationController, animated: animated)
        self.navigationController = navigationController
    }
    
    func finish(animated: Bool) {
        // ...
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
