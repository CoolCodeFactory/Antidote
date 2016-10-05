//
//  UserFlowCoordinator.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class UserFlowCoordinator: CoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    weak var navigationController: NavigationViewController!
    
    var closeHandler: () -> () = { fatalError() }
    
    let viewControllersFactory = UserViewControllersFactory()
    
    
    func start(animated: Bool) {
        fatalError()
    }
    
    @objc func end(_ sender: UIBarButtonItem) {
        fatalError()
    }
    
    func finish(animated: Bool) {
        fatalError()
    }
    
    fileprivate func presentUserViewController(withName name: String) {
        fatalError()
    }
}


class UserModalFlowCoordinator: UserFlowCoordinator, ModalCoordinatorProtocol {
    
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    override func start(animated: Bool) {
        let viewController = viewControllersFactory.usersTableViewController()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        viewController.selectUserHandler = { [unowned self] name in
            self.presentUserViewController(withName: name)
        }
        
        let navVC = viewControllersFactory.navigationController()
        navVC.setViewControllers([viewController], animated: false)
        
        presentingViewController.present(navVC, animated: true, completion: nil)
        navigationController = navVC
    }
    
    override func finish(animated: Bool) {
        removeAllChildCoordinators()

        navigationController.dismiss(animated: animated, completion: nil)
        
        let alertController = UIAlertController(title: "Finished!", message: "\(String(describing: self)) did finish", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        presentingViewController.present(alertController, animated: true, completion: nil)
    }
    
    @objc override func end(_ sender: UIBarButtonItem) {
        closeHandler()
    }
    
    fileprivate override func presentUserViewController(withName name: String) {
        let viewController = viewControllersFactory.userViewController(withName: name)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


class UserNavigationFlowCoordinator: UserFlowCoordinator, NavigationCoordinatorProtocol {
    
    weak var presentingNavigationController: NavigationViewController!
    
    required init(presentingNavigationController: NavigationViewController) {
        self.presentingNavigationController = presentingNavigationController
    }
    
    override func start(animated: Bool) {
        let viewController = viewControllersFactory.usersTableViewController()
        viewController.controllerCloseHandler = { [unowned self] in
            self.closeHandler()
        }
        viewController.selectUserHandler = { [unowned self] name in
            self.presentUserViewController(withName: name)
        }
        
        presentingNavigationController.pushViewController(viewController, animated: animated)
    }
    
    override func finish(animated: Bool) {
        removeAllChildCoordinators()

        let alertController = UIAlertController(title: "Finished!", message: "\(String(describing: self)) did finish", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        presentingNavigationController.present(alertController, animated: true, completion: nil)
    }
    
    @objc override func end(_ sender: UIBarButtonItem) {
        closeHandler()
    }
    
    fileprivate override func presentUserViewController(withName name: String) {
        let viewController = viewControllersFactory.userViewController(withName: name)
        presentingNavigationController?.pushViewController(viewController, animated: true)
    }
}


class UserMasterDetailFlowCoordinator: UserFlowCoordinator, MasterDetailCoordinatorProtocol {
    
    weak var splitViewController: UISplitViewController!
    
    required init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }
    
    override func start(animated: Bool) {
        let viewController = viewControllersFactory.usersTableViewController()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        viewController.selectUserHandler = { [unowned self] name in
            self.presentUserViewController(withName: name)
        }
        
        let navVC = viewControllersFactory.navigationController()
        navVC.setViewControllers([viewController], animated: false)
        
        splitViewController.viewControllers = [navVC]
    }
    
    override func finish(animated: Bool) {
        removeAllChildCoordinators()

        let alertController = UIAlertController(title: "Finished!", message: "\(String(describing: self)) did finish", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        splitViewController.presentingViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc override func end(_ sender: UIBarButtonItem) {
        closeHandler()
    }
    
    fileprivate override func presentUserViewController(withName name: String) {

        let viewController = viewControllersFactory.userViewController(withName: name)
        let navVC = viewControllersFactory.navigationController()
        navVC.setViewControllers([viewController], animated: false)
        
        splitViewController.showDetailViewController(navVC, sender: nil)
    }
}


class UserPageBasedFlowCoordinator: UserFlowCoordinator, PageBasedCoordinatorProtocol {

    weak var pageViewController: PageBasedViewController!
    
    required init(pageViewController: PageBasedViewController) {
        self.pageViewController = pageViewController
    }
    
    override func start(animated: Bool) {
        let viewController = viewControllersFactory.usersTableViewController()
        pageViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))

        viewController.selectUserHandler = { [unowned self] name in
            self.presentUserViewController(withName: name)
        }
        
        if var viewControllers = pageViewController.viewControllers {
            viewControllers.append(viewController)
            pageViewController.setViewControllers(viewControllers)
        } else {
            pageViewController.setViewControllers([viewController])
        }
    }
    
    override func finish(animated: Bool) {
        removeAllChildCoordinators()

        let alertController = UIAlertController(title: "Finished!", message: "\(String(describing: self)) did finish", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        pageViewController.presentingViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc override func end(_ sender: UIBarButtonItem) {
        closeHandler()
    }
    
    fileprivate override func presentUserViewController(withName name: String) {
        let viewController = viewControllersFactory.userViewController(withName: name)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        
        let viewControllers = pageViewController.viewControllers!
        var filteredViewControllers = viewControllers.filter({ (viewController) -> Bool in
            return !(viewController is UserViewController)
        })
        filteredViewControllers.append(viewController)
        pageViewController.setViewControllers(filteredViewControllers)
        
        let alertController = UIAlertController(title: "Second page appeared", message: "UserViewController opened in the second page", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        pageViewController.present(alertController, animated: true, completion: nil)
    }
}


class UserTabbedFlowCoordinator: UserFlowCoordinator, TabbedCoordinatorProtocol {
    
    weak var tabBarController: UITabBarController!
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    override func start(animated: Bool) {
        let viewController = viewControllersFactory.usersTableViewController()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
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
    
    override func finish(animated: Bool) {
        removeAllChildCoordinators()

        let alertController = UIAlertController(title: "Finished!", message: "\(String(describing: self)) did finish", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        tabBarController.presentingViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc override func end(_ sender: UIBarButtonItem) {
        closeHandler()
    }
    
    fileprivate override func presentUserViewController(withName name: String) {
        let viewController = viewControllersFactory.userViewController(withName: name)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        
        let navVC = viewControllersFactory.navigationController()
        navVC.setViewControllers([viewController], animated: false)
        
        let viewControllers = tabBarController.viewControllers!
        var filteredViewControllers = viewControllers.filter({ (viewController) -> Bool in
            guard let navVC = viewController as? NavigationViewController else { return true }
            return !(navVC.viewControllers.first is UserViewController)
        })
        filteredViewControllers.append(navVC)
        tabBarController.setViewControllers(filteredViewControllers, animated: false)
        
        let alertController = UIAlertController(title: "Second tab appeared", message: "UserViewController opened in the second tab", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        tabBarController.present(alertController, animated: true, completion: nil)
    }
}


class UserContainerFlowCoordinator: UserFlowCoordinator, ModalCoordinatorProtocol {
   
    weak var presentingViewController: UIViewController!
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    override func start(animated: Bool) {
        let viewController = viewControllersFactory.userContainerViewController()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(end(_:)))
        viewController.usersViewControllerBuilder = { [unowned self, weak viewController] in
            let usersTableViewController = self.viewControllersFactory.usersTableViewController()
            usersTableViewController.selectUserHandler = { [weak viewController] name in
                viewController?.updateUserViewController(name)
            }
            return usersTableViewController
        }
        viewController.userViewControllerBuilder = { [unowned self] name in
            let userViewController = self.viewControllersFactory.userViewController(withName: name)
            return userViewController
        }

        
        let navVC = viewControllersFactory.navigationController()
        navVC.setViewControllers([viewController], animated: false)
        
        presentingViewController.present(navVC, animated: true, completion: nil)
        navigationController = navVC
    }
    
    @objc override func end(_ sender: UIBarButtonItem) {
        closeHandler()
    }
    
    override func finish(animated: Bool) {
        removeAllChildCoordinators()

        navigationController.dismiss(animated: animated, completion: nil)
        
        let alertController = UIAlertController(title: "Finished!", message: "\(String(describing: self)) did finish", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        presentingViewController.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate override func presentUserViewController(withName name: String) {
        
    }
}
