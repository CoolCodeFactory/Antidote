//
//  Page-BasedFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class PageBasedFlowCoordinator: ModalCoordinatorProtocol {
    
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = PageBasedViewControllersFactory()

    var userFlowCoordinator: UserFlowCoordinator!
    weak var pageBasedViewController: PageBasedViewController!
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func start(animated animated: Bool) {
        pageBasedViewController = viewControllersFactory.pageBasedViewController()
        userFlowCoordinator = UserPageBasedFlowCoordinator(pageViewController: pageBasedViewController)
        
        
        userFlowCoordinator.start(animated: animated)
        userFlowCoordinator.closeHandler = { [unowned self] in
            self.pageBasedViewController.dismissViewControllerAnimated(animated, completion: nil)
        }
        presentingViewController.presentViewController(pageBasedViewController, animated: animated, completion: nil)
    }
}