//
//  Master-DetailFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class MasterDetailFlowCoordinator: ModalCoordinatorProtocol {

    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = MasterDetailViewControllersFactory()
    
    weak var masterDetailViewController: UISplitViewController!
    var userFlowCoordinator: UserFlowCoordinator!
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated: Bool) {
        masterDetailViewController = viewControllersFactory.masterDetailViewController()
        userFlowCoordinator = UserMasterDetailFlowCoordinator(splitViewController: masterDetailViewController)

        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = { [unowned self] in
            self.userFlowCoordinator.finish(animated: animated)
            self.closeHandler()
        }
        presentingViewController.present(masterDetailViewController, animated: animated, completion: nil)
    }
    
    func finish(animated: Bool) {
        masterDetailViewController.dismiss(animated: animated, completion: nil)
    }

}
