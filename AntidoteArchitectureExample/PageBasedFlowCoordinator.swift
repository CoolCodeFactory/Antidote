//
//  Page-BasedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class PageBasedFlowCoordinator: ModalCoordinatorProtocol {
    
    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = PageBasedViewControllersFactory()

    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated animated: Bool) {
        let viewController = viewControllersFactory.pageBasedViewController()
        presentingViewController.presentViewController(viewController, animated: true, completion: nil)
    }
}