//
//  TabbedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit



class TabbedFlowCoordinator: ModalCoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    weak var navigationController: UINavigationController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = TabbedViewControllersFactory()

    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.tabbedController()
        let userFlowCoordinator = UserFlowCoordinator(tabBarController: viewController)
        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = {
            viewController.dismissViewControllerAnimated(animated, completion: nil)
            self.removeChildCoordinator(userFlowCoordinator)
        }
        presentingViewController.presentViewController(viewController, animated: animated, completion: nil)
        addChildCoordinator(userFlowCoordinator)
    }

}