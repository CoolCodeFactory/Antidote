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
    
    func displayContentController(contentController: UIViewController, inView view: UIView, animated: Bool, duration: NSTimeInterval = kDefaultAnimationDuration) {
        addChildViewController(contentController)
        view.addSubview(contentController.view)
        contentController.view.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        if animated {
            contentController.view.alpha = 0.0
            UIView.animateWithDuration(duration, animations: { 
                contentController.view.alpha = 1.0
            }, completion: { (finished) in
                contentController.didMoveToParentViewController(self)
            })
        } else {
            contentController.didMoveToParentViewController(self)
        }
    }
    
    func hideContentController(animated animated: Bool, duration: NSTimeInterval = kDefaultAnimationDuration) {
        if animated {
            UIView.animateWithDuration(duration, animations: {
                self.view.alpha = 0.0
            }) { (finished) in
                self.willMoveToParentViewController(nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        } else {
            willMoveToParentViewController(nil)
            view.removeFromSuperview()
            removeFromParentViewController()
        }
    }
    
    func exchangeContentController(fromContentController fromContentController: UIViewController, toContentController: UIViewController, inView view: UIView, animated: Bool, duration: NSTimeInterval = kDefaultAnimationDuration) {
        fromContentController.willMoveToParentViewController(nil)
        addChildViewController(toContentController)
        
        toContentController.view.frame = fromContentController.view.frame
        
        transitionFromViewController(fromContentController, toViewController: toContentController, duration: duration, options: [.TransitionCrossDissolve], animations: {
            toContentController.view.snp_makeConstraints { (make) in
                make.edges.equalTo(view)
            }
        }) { (finished) in
            fromContentController.removeFromParentViewController()
            toContentController.didMoveToParentViewController(self)
        }
    }
    
    class var className: String {
        return String(self)
    }
    
    private class func instantiateControllerInStoryboard<T: UIViewController>(storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewControllerWithIdentifier(identifier) as! T
    }
    
    class func controllerFromStoryboard(storyboard: UIStoryboard) -> Self {
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
