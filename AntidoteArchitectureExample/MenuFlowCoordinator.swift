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
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.menuTableViewController()
        let navigationController = NavigationViewController(rootViewController: viewController)
        
        masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: navigationController)
        pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: navigationController)
        tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: navigationController)
        userModalFlowCoordinator = UserModalFlowCoordinator(presentingViewController: navigationController)
        userFlowCoordinator = UserNavigationFlowCoordinator(presentingNavigationController: navigationController)
        userContainerFlowCoordinator = UserContainerFlowCoordinator(presentingViewController: navigationController)
        
        viewController.selectMasterDetailHandler = showMasterDetail(animated: animated)
        viewController.selectPageBasedHandler = showPageBased(animated: animated)
        viewController.selectTabbedHandler = showTabbed(animated: animated)
        viewController.selectModalHandler = showModal(animated: animated)
        viewController.selectPushHandler = showPush(animated: animated)
        viewController.selectContainerHandler = showContainer(animated: animated)
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
        window.setRootViewController(navigationController, animated: animated)
        self.navigationController = navigationController
    }
    
    
    deinit {
        print("Deinit: \(self)")
    }
    
    func showMasterDetail(animated animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.masterDetailFlowCoordinator.closeHandler = { }
            self.masterDetailFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showPageBased(animated animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.pageBasedFlowCoordinator.closeHandler = { }
            self.pageBasedFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showTabbed(animated animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.tabbedFlowCoordinator.closeHandler = { }
            self.tabbedFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showModal(animated animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.userModalFlowCoordinator.closeHandler = { }
            self.userModalFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showPush(animated animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.userFlowCoordinator.closeHandler = { }
            self.userFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showContainer(animated animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.userContainerFlowCoordinator.closeHandler = { }
            self.userContainerFlowCoordinator.start(animated: animated)
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
