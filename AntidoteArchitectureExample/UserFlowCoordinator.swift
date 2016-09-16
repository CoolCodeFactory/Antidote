//
//  UserFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class UserFlowCoordinator: ModalCoordinatorProtocol, MasterDetailCoordinatorProtocol, PageBasedCoordinatorProtocol, TabbedCoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    weak var navigationController: UINavigationController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = UserViewControllersFactory()
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    weak var tabBarController: UITabBarController!
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    weak var pageViewController: UIPageViewController!
    
    required init(pageViewController: UIPageViewController) {
        self.pageViewController = pageViewController
    }

    weak var splitViewController: UISplitViewController!
    
    required init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }
    
    func start(animated animated: Bool) {
        if presentingViewController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            viewController.selectUserHandler = { name in
                self.presentUserViewController(withName: name)
            }
            // FIXME: Move to Storyboard
            let navVC = UINavigationController(rootViewController: viewController)
            navVC.title = "Users"

            presentingViewController.presentViewController(navVC, animated: true, completion: nil)
            navigationController = navVC
        }
        if splitViewController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            viewController.selectUserHandler = { name in
                self.presentUserViewController(withName: name)
            }
            // FIXME: Move to Storyboard
            let navVC = UINavigationController(rootViewController: viewController)
            navVC.title = "Users"
            
            splitViewController.viewControllers = [navVC]
        }
        if pageViewController != nil {
            
        }
        if tabBarController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            viewController.selectUserHandler = { name in
                self.presentUserViewController(withName: name)
            }
            // FIXME: Move to Storyboard
            let navVC = UINavigationController(rootViewController: viewController)
            navVC.title = "Users"
            
            if var viewControllers = tabBarController.viewControllers {
                viewControllers.append(navVC)
                tabBarController.setViewControllers(viewControllers, animated: false)
            } else {
                tabBarController.setViewControllers([navVC], animated: false)
            }
        }
    }
    
    @objc func end(sender: UIBarButtonItem) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        closeHandler()
    }
    
    private func presentUserViewController(withName name: String) {
        if presentingViewController != nil {
            let viewController = viewControllersFactory.userViewController(withName: name)
            navigationController?.pushViewController(viewController, animated: true)
        }
        if splitViewController != nil {
            let viewController = viewControllersFactory.userViewController(withName: name)
            
            // FIXME: Move to Storyboard
            let navVC = UINavigationController(rootViewController: viewController)
            navVC.title = "User"
            
            splitViewController.showDetailViewController(navVC, sender: nil)
        }
        if pageViewController != nil {
            fatalError()
        }
        if tabBarController != nil {
            let viewController = viewControllersFactory.userViewController(withName: name)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            
            // FIXME: Move to Storyboard
            let navVC = UINavigationController(rootViewController: viewController)
            navVC.title = "User"
            
            let viewControllers = tabBarController.viewControllers!
            var filteredViewControllers = viewControllers.filter({ (viewController) -> Bool in
                guard let navVC = viewController as? UINavigationController else { return true }
                return !(navVC.viewControllers.first is UserViewController)
            })
            filteredViewControllers.append(navVC)
            tabBarController.setViewControllers(filteredViewControllers, animated: false)
        }
    }
}
