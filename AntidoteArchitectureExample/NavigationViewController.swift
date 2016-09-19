//
//  NavigationViewController.swift
//  AntidoteArchitectureExample
//
//  Created by Dima on 19/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class NavigationViewController: UINavigationController {
    
    enum NavigationViewControllerOperationType: String {
        case Pop
        case Push
        case None
    }
    
    private var viewControllersCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func setViewControllers(viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        
        viewControllersCount = viewControllers.count
        
        print("setViewControllers: \(viewControllers)")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        viewControllersCount = viewControllers.count
        
        print("nibName:bundle: \(viewControllers)")
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        viewControllersCount = viewControllers.count
        
        print("rootViewController: \(rootViewController)")
        print("viewControllers: \(viewControllers)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewControllersCount = viewControllers.count
        
        print("coder:")
        print("viewControllers: \(viewControllers)")
    }
    
    deinit {
        print("deinit")
        print("viewControllers: \(self.dynamicType)")
    }
    
    class ObservedViewController {
        unowned let viewController: UIViewController
        let completionHandler: (() -> ())
        
        init(viewController: UIViewController, completionHandler: (() -> ())) {
            self.viewController = viewController
            self.completionHandler = completionHandler
        }
    }
    var observedViewControllers = [ObservedViewController]()
    
    func observeCurrentViewController(completionHandler: () -> ()) {
        let observedViewController = ObservedViewController(viewController: topViewController!, completionHandler: completionHandler)
        observedViewControllers.append(observedViewController)
    }
}

extension NavigationViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        viewControllers.count
        let operation: NavigationViewControllerOperationType
        if viewControllers.count > viewControllersCount {
            viewControllersCount = viewControllers.count
            operation = NavigationViewControllerOperationType.Push
        } else if viewControllers.count < viewControllersCount {
            viewControllersCount = viewControllers.count
            operation = NavigationViewControllerOperationType.Pop
        } else {
            operation = NavigationViewControllerOperationType.None
        }
        
        if operation == .Pop {
            for observedViewController in observedViewControllers {
                if viewController == observedViewController.viewController {
                    observedViewController.completionHandler()
                    guard let index = observedViewControllers.indexOf({ $0 === observedViewController }) else { break }
                    observedViewControllers.removeAtIndex(index)
                }
            }
            print(observedViewControllers)
        }
    }
}
