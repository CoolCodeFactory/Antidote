//
//  TabbedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit



class TabbedFlowCoordinator: ModalCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = TabbedViewControllersFactory()

    weak var tabBarController: UITabBarController!
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated: Bool) {
        tabBarController = viewControllersFactory.tabbedController()
        
        let userFlowCoordinator = UserTabbedFlowCoordinator(tabBarController: tabBarController)
        addChildCoordinator(userFlowCoordinator)
        userFlowCoordinator.closeHandler = { [unowned self] in
            userFlowCoordinator.finish(animated: animated)
            self.removeChildCoordinator(userFlowCoordinator)
            self.closeHandler()
        }
        userFlowCoordinator.start(animated: animated)

        presentingViewController.present(tabBarController, animated: animated, completion: nil)
    }
    
    func finish(animated: Bool) {
        removeAllChildCoordinators()
        tabBarController.dismiss(animated: true, completion: nil)
    }

}
