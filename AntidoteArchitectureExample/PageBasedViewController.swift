//
//  PageBasedViewController.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


class PageBasedViewController: UIPageViewController {


    fileprivate var _viewControllers: [UIViewController]!

    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)?) {
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]?) {
        _viewControllers = viewControllers
        _viewControllers.forEach { $0.automaticallyAdjustsScrollViewInsets = false }
        
        let currentViewController = _viewControllers.first!
        setViewControllers([currentViewController], direction: .forward, animated:true, completion:nil)
        
        dataSource = nil
        dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        let currentViewController = _viewControllers.first!
        setViewControllers([currentViewController], direction: .forward, animated:true, completion:nil)
        view.backgroundColor = UIColor.white
        
        configurePageControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _viewControllers.forEach { (viewController) in
            if let tvc = viewController as? UITableViewController {
                let height = (self.navigationController?.navigationBar.frame.height ?? 0) + min(UIApplication.shared.statusBarFrame.size.width, UIApplication.shared.statusBarFrame.size.height)
                tvc.tableView.contentInset.top = height
                tvc.tableView.scrollIndicatorInsets.top = height
            }
        }
    }
    
    func configurePageControl() {
        var foundedPageControl: UIPageControl?
        for subview in view.subviews {
            if let pageControlSubview = subview as? UIPageControl {
                foundedPageControl = pageControlSubview
                break
            }
        }
        guard let pageControl = foundedPageControl else { return }
        
        pageControl.pageIndicatorTintColor = view.tintColor.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = view.tintColor
        pageControl.backgroundColor = view.backgroundColor
    }
    
    deinit {
        print("DEINIT: \(self)")
    }
}

extension PageBasedViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == self._viewControllers.first {
            return nil
        } else {
            let priorPageIndex = self._viewControllers.index(of: viewController)! - 1
            return self._viewControllers[priorPageIndex]
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == self._viewControllers.last {
            return nil
        } else {
            let nextPageIndex = self._viewControllers.index(of: viewController)! + 1
            return self._viewControllers[nextPageIndex]
        }
    }
    
}

extension PageBasedViewController: UIPageViewControllerDelegate {
    
    @objc(presentationCountForPageViewController:) func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return _viewControllers.count
    }
    
    @objc(presentationIndexForPageViewController:) func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
