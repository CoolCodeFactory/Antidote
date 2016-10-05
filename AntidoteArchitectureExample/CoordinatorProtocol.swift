//
//  CoordinatorProtocol.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


protocol CoordinatorProtocol: class {
    
    weak var navigationController: NavigationViewController! { get set }

    var closeHandler: () -> () { get set }
    
    func start(animated: Bool)
    func finish(animated: Bool)
}

protocol RootCoordinatorProtocol: CoordinatorProtocol {
    
    weak var window: UIWindow! { get set }
        
    init(window: UIWindow)
}

protocol ModalCoordinatorProtocol: CoordinatorProtocol {
    
    weak var presentingViewController: UIViewController! { get }
    
    init(presentingViewController: UIViewController)
}

protocol TabbedCoordinatorProtocol: CoordinatorProtocol {
    
    weak var tabBarController: UITabBarController! { get }
    
    init(tabBarController: UITabBarController)
}

protocol PageBasedCoordinatorProtocol: CoordinatorProtocol {
    
    weak var pageViewController: PageBasedViewController! { get }
    
    init(pageViewController: PageBasedViewController)
}

protocol MasterDetailCoordinatorProtocol: CoordinatorProtocol {
    
    weak var splitViewController: UISplitViewController! { get }
    
    init(splitViewController: UISplitViewController)
}

protocol NavigationCoordinatorProtocol: CoordinatorProtocol {
    
    weak var presentingNavigationController: NavigationViewController! { get }
    
    init(presentingNavigationController: NavigationViewController)
}








