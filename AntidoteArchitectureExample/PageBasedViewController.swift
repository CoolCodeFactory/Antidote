//
//  PageBasedViewController.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class PageBasedViewController: UIPageViewController {


    private var _viewControllers: [UIViewController]!

    override func setViewControllers(viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)?) {
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
    }
    
    func setViewControllers(viewControllers: [UIViewController]?) {
        _viewControllers = viewControllers
        
        let currentViewController = _viewControllers.first!
        setViewControllers([currentViewController], direction: .Forward, animated:true, completion:nil)
        
        dataSource = nil
        dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        doubleSided = true
        
        let currentViewController = _viewControllers.first!
        setViewControllers([currentViewController], direction: .Forward, animated:true, completion:nil)
        view.backgroundColor = UIColor.clearColor()
    }
    
    deinit {
        print("DEINIT: \(self)")
    }
}

extension PageBasedViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController == self._viewControllers.first {
            return nil
        } else {
            let priorPageIndex = self._viewControllers.indexOf(viewController)! - 1
            return self._viewControllers[priorPageIndex]
        }
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController == self._viewControllers.last {
            return nil
        } else {
            let nextPageIndex = self._viewControllers.indexOf(viewController)! + 1
            return self._viewControllers[nextPageIndex]
        }
    }
    
}

extension PageBasedViewController: UIPageViewControllerDelegate {
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return _viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == false {
            return
        }
        
        let viewController = pageViewController.viewControllers!.last!
        let newIndex = self._viewControllers.indexOf(viewController)!
    }
}
