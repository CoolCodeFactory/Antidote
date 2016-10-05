//
//  Master-DetailFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MasterDetailFlowCoordinator: ModalCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []

    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = MasterDetailViewControllersFactory()
    
    weak var masterDetailViewController: UISplitViewController!
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated: Bool) {
        masterDetailViewController = viewControllersFactory.masterDetailViewController()
        
        let userFlowCoordinator = UserMasterDetailFlowCoordinator(splitViewController: masterDetailViewController)
        addChildCoordinator(userFlowCoordinator)
        userFlowCoordinator.closeHandler = { [unowned userFlowCoordinator] in
            userFlowCoordinator.finish(animated: animated)
            self.removeChildCoordinator(userFlowCoordinator)
            self.closeHandler()
        }
        userFlowCoordinator.start(animated: animated)

        presentingViewController.present(masterDetailViewController, animated: animated, completion: nil)
    }
    
    func finish(animated: Bool) {
        removeAllChildCoordinators()
        masterDetailViewController.dismiss(animated: animated, completion: nil)
    }

}
