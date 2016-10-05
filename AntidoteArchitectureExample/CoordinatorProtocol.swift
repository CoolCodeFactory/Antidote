//
//  CoordinatorProtocol.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

protocol BaseCoordinatorProtocol: class {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    var closeHandler: () -> () { get set }
    
    func start(animated: Bool)
    func finish(animated: Bool)
}

protocol CoordinatorProtocol: BaseCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] { get set }

    weak var navigationController: NavigationViewController! { get set }
}

extension BaseCoordinatorProtocol {
    
    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        guard let index = self.childCoordinators.index(where: {$0 === coordinator}) else { return }
        childCoordinators.remove(at: index)
    }
    
    func removeAllChildCoordinators() {
        for childCoordinator in childCoordinators {
            removeChildCoordinator(childCoordinator)
        }
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








