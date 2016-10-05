//
//  UIViewController+Extensions.swift
//  Surf
//
//  Created by Dima on 19/08/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func displayContentController(_ contentController: UIViewController, inView view: UIView, animated: Bool, duration: TimeInterval = kDefaultAnimationDuration) {
        addChildViewController(contentController)
        view.addSubview(contentController.view)
        contentController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        if animated {
            contentController.view.alpha = 0.0
            UIView.animate(withDuration: duration, animations: { 
                contentController.view.alpha = 1.0
            }, completion: { (finished) in
                contentController.didMove(toParentViewController: self)
            })
        } else {
            contentController.didMove(toParentViewController: self)
        }
    }
    
    func hideContentController(animated: Bool, duration: TimeInterval = kDefaultAnimationDuration) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.view.alpha = 0.0
            }, completion: { (finished) in
                self.willMove(toParentViewController: nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }) 
        } else {
            willMove(toParentViewController: nil)
            view.removeFromSuperview()
            removeFromParentViewController()
        }
    }
    
    func exchangeContentController(fromContentController: UIViewController, toContentController: UIViewController, inView view: UIView, animated: Bool, duration: TimeInterval = kDefaultAnimationDuration) {
        fromContentController.willMove(toParentViewController: nil)
        addChildViewController(toContentController)
        
        toContentController.view.frame = fromContentController.view.frame
        
        transition(from: fromContentController, to: toContentController, duration: duration, options: [.transitionCrossDissolve], animations: {
            toContentController.view.snp.makeConstraints { (make) in
                make.edges.equalTo(view)
            }
        }) { (finished) in
            fromContentController.removeFromParentViewController()
            toContentController.didMove(toParentViewController: self)
        }
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    fileprivate class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    class func controllerFromStoryboard(_ storyboard: UIStoryboard) -> Self {
        return instantiateControllerInStoryboard(storyboard, identifier: className)
    }
    
    func childViewController<T>() -> T? {
        for childViewController in childViewControllers {
            if let _childViewController = childViewController as? T {
                return _childViewController
            }
        }
        return nil
    }
}
