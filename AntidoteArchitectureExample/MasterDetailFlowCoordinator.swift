//
//  Master-DetailFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MasterDetailFlowCoordinator: ModalCoordinatorProtocol {

    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = MasterDetailViewControllersFactory()
    
    let masterDetailViewController: UISplitViewController
    let userFlowCoordinator: UserFlowCoordinator
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        
        masterDetailViewController = viewControllersFactory.masterDetailViewController()
        userFlowCoordinator = UserFlowCoordinator(splitViewController: masterDetailViewController)
    }
    
    func start(animated animated: Bool) {
        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = { [unowned self] in
            self.masterDetailViewController.dismissViewControllerAnimated(animated, completion: nil)
        }
        presentingViewController.presentViewController(masterDetailViewController, animated: animated, completion: nil)
    }

}
