//
//  UserFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class UserFlowCoordinator: CoordinatorProtocol, ModalCoordinatorProtocol, MasterDetailCoordinatorProtocol, PageBasedCoordinatorProtocol, TabbedCoordinatorProtocol, NavigationCoordinatorProtocol {
    
    // MARK: - CoordinatorProtocol
    weak var navigationController: NavigationViewController?
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = UserViewControllersFactory()
    
    // MARK: - ModalCoordinatorProtocol
    weak var splitViewController: UISplitViewController!
    
    required init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }
    
    // MARK: - MasterDetailCoordinatorProtocol
    weak var tabBarController: UITabBarController!
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    // MARK: - PageBasedCoordinatorProtocol
    weak var pageViewController: UIPageViewController!
    
    required init(pageViewController: UIPageViewController) {
        self.pageViewController = pageViewController
    }

    // MARK: - TabbedCoordinatorProtocol
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    // MARK: - NavigationCoordinatorProtocol
    weak var presentingNavigationController: NavigationViewController!
    
    required init(presentingNavigationController: NavigationViewController) {
        self.presentingNavigationController = presentingNavigationController
    }
    
    
    func start(animated animated: Bool) {
        if presentingViewController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            viewController.selectUserHandler = { [unowned self] name in
                self.presentUserViewController(withName: name)
            }
            
            let navVC = viewControllersFactory.navigationController()
            navVC.setViewControllers([viewController], animated: false)

            presentingViewController.presentViewController(navVC, animated: true, completion: nil)
            navigationController = navVC
        }
        
        if splitViewController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            viewController.selectUserHandler = { [unowned self] name in
                self.presentUserViewController(withName: name)
            }
            
            let navVC = viewControllersFactory.navigationController()
            navVC.setViewControllers([viewController], animated: false)
            
            splitViewController.viewControllers = [navVC]
        }
        
        if pageViewController != nil {
            
        }
        
        if tabBarController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            viewController.selectUserHandler = { [unowned self] name in
                self.presentUserViewController(withName: name)
            }
            let navVC = viewControllersFactory.navigationController()
            navVC.setViewControllers([viewController], animated: false)
            
            if var viewControllers = tabBarController.viewControllers {
                viewControllers.append(navVC)
                tabBarController.setViewControllers(viewControllers, animated: false)
            } else {
                tabBarController.setViewControllers([navVC], animated: false)
            }
        }
        
        if presentingNavigationController != nil {
            let viewController = viewControllersFactory.usersTableViewController()
            viewController.selectUserHandler = { [unowned self] name in
                self.presentUserViewController(withName: name)
            }
            
            presentingNavigationController.pushViewController(viewController, animated: animated)
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
            let navVC = viewControllersFactory.navigationController()
            navVC.setViewControllers([viewController], animated: false)
            
            splitViewController.showDetailViewController(navVC, sender: nil)
        }
        
        if pageViewController != nil {
            fatalError()
        }
        
        if tabBarController != nil {
            let viewController = viewControllersFactory.userViewController(withName: name)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(end(_:)))
            
            let navVC = viewControllersFactory.navigationController()
            navVC.setViewControllers([viewController], animated: false)
            
            let viewControllers = tabBarController.viewControllers!
            var filteredViewControllers = viewControllers.filter({ (viewController) -> Bool in
                guard let navVC = viewController as? NavigationViewController else { return true }
                return !(navVC.viewControllers.first is UserViewController)
            })
            filteredViewControllers.append(navVC)
            tabBarController.setViewControllers(filteredViewControllers, animated: false)
        }
        
        if presentingNavigationController != nil {
            let viewController = viewControllersFactory.userViewController(withName: name)
            presentingNavigationController?.pushViewController(viewController, animated: true)
        }
    }
}
