//
//  TabbedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit



class TabbedFlowCoordinator: ModalCoordinatorProtocol {
    
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = TabbedViewControllersFactory()

    var userFlowCoordinator: UserFlowCoordinator!
    weak var tabBarController: UITabBarController!
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated: Bool) {
        tabBarController = viewControllersFactory.tabbedController()
        userFlowCoordinator = UserTabbedFlowCoordinator(tabBarController: tabBarController)

        
        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = { [unowned self] in
            self.userFlowCoordinator.finish(animated: animated)
            self.closeHandler()
        }
        presentingViewController.present(tabBarController, animated: animated, completion: nil)
    }
    
    func finish(animated: Bool) {
        tabBarController.dismiss(animated: true, completion: nil)
    }

}
