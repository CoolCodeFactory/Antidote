//
//  Master-DetailFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MasterDetailFlowCoordinator: ModalCoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = MasterDetailViewControllersFactory()

    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.masterDetailViewController()
        let userFlowCoordinator = UserFlowCoordinator(splitViewController: viewController)
        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = { [unowned self, unowned userFlowCoordinator, weak viewController] in
            viewController?.dismissViewControllerAnimated(animated, completion: nil)
            self.removeChildCoordinator(userFlowCoordinator)
        }
        presentingViewController.presentViewController(viewController, animated: animated, completion: nil)
        addChildCoordinator(userFlowCoordinator)
    }

}
