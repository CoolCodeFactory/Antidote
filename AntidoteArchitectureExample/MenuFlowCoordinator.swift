//
//  MenuFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MenuFlowCoordinator: RootCoordinatorProtocol {
    
    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    weak var window: UIWindow!
    
    let viewControllersFactory = MenuViewControllersFactory()
    
    let masterDetailFlowCoordinator: MasterDetailFlowCoordinator
    let pageBasedFlowCoordinator: PageBasedFlowCoordinator
    let tabbedFlowCoordinator: TabbedFlowCoordinator
    let userFlowCoordinator: UserFlowCoordinator
    let userModalFlowCoordinator: UserFlowCoordinator

    let viewController: MenuTableViewController
    let navVC: NavigationViewController

    required init(window: UIWindow) {
        self.window = window
        
        viewController = viewControllersFactory.menuTableViewController()
        navVC = NavigationViewController(rootViewController: viewController)

        masterDetailFlowCoordinator = MasterDetailFlowCoordinator(presentingViewController: viewController)
        pageBasedFlowCoordinator = PageBasedFlowCoordinator(presentingViewController: viewController)
        tabbedFlowCoordinator = TabbedFlowCoordinator(presentingViewController: viewController)
        userModalFlowCoordinator = UserFlowCoordinator(presentingViewController: viewController)
        userFlowCoordinator = UserFlowCoordinator(presentingNavigationController: navVC)
    }
    
    func start(animated animated: Bool) {
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
        let handler = { [unowned self] in
            self.masterDetailFlowCoordinator.closeHandler = { }
            self.masterDetailFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showPageBased(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.pageBasedFlowCoordinator.closeHandler = { }
            self.pageBasedFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showTabbed(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.tabbedFlowCoordinator.closeHandler = { }
            self.tabbedFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showModal(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.userModalFlowCoordinator.closeHandler = { }
            self.userModalFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showPush(withNavigationController navigationController: NavigationViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.userFlowCoordinator.closeHandler = { }
            self.userFlowCoordinator.start(animated: animated)
        }
        return handler
    }
    
    func showContainer(withViewController viewController: UIViewController, animated: Bool) -> (() -> ()) {
        let handler = { [unowned self] in
            self.userModalFlowCoordinator.closeHandler = { }
            self.userModalFlowCoordinator.start(animated: animated)
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
