//
//  TabbedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit



class TabbedFlowCoordinator: ModalCoordinatorProtocol {
    
    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = TabbedViewControllersFactory()

    let userFlowCoordinator: UserFlowCoordinator
    let tabBarController: UITabBarController
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        
        tabBarController = viewControllersFactory.tabbedController()
        userFlowCoordinator = UserFlowCoordinator(tabBarController: tabBarController)
    }
    
    func start(animated animated: Bool) {
        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = { [unowned self] in
            self.tabBarController.dismissViewControllerAnimated(animated, completion: nil)
        }
        presentingViewController.presentViewController(tabBarController, animated: animated, completion: nil)
    }

}