//
//  Page-BasedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class PageBasedFlowCoordinator: ModalCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []

    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = PageBasedViewControllersFactory()

    weak var pageBasedViewController: PageBasedViewController!
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated: Bool) {
        pageBasedViewController = viewControllersFactory.pageBasedViewController()
        let navigationController = NavigationViewController(rootViewController: pageBasedViewController)

        let userFlowCoordinator = UserPageBasedFlowCoordinator(pageViewController: pageBasedViewController)
        addChildCoordinator(userFlowCoordinator)
        userFlowCoordinator.closeHandler = { [unowned userFlowCoordinator] in
            userFlowCoordinator.finish(animated: animated)
            self.removeChildCoordinator(userFlowCoordinator)
            self.closeHandler()
        }
        userFlowCoordinator.start(animated: animated)
        
        presentingViewController.present(navigationController, animated: animated, completion: nil)
        self.navigationController = navigationController
    }
    
    func finish(animated: Bool) {
        removeAllChildCoordinators()
        navigationController.dismiss(animated: animated, completion: nil)
    }
}
