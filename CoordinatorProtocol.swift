//
//  CoordinatorProtocol.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


protocol CoordinatorProtocol: class {
    
    var childCoordinators: [CoordinatorProtocol] { get set }

    weak var navigationController: UINavigationController? { get set }

    var closeHandler: () -> () { get set }
    
    func start(animated animated: Bool)
}

extension CoordinatorProtocol {
    
    func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains({ $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        guard let index = self.childCoordinators.indexOf({$0 === coordinator}) else { return }
        childCoordinators.removeAtIndex(index)
    }
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
    
    weak var pageViewController: UIPageViewController! { get }
    
    init(pageViewController: UIPageViewController)
}

protocol MasterDetailCoordinatorProtocol: CoordinatorProtocol {
    
    weak var splitViewController: UISplitViewController! { get }
    
    init(splitViewController: UISplitViewController)
}