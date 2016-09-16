//
//  UIWindow+Extensions.swift
//  AntidoteArchitectureExample
//
//  Created by Dmitriy Utmanov on 16/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit


extension UIWindow {
    
    func setRootViewController(viewController: UIViewController, animated: Bool) {
        if animated {
            // FIXME: NavBar Blink - http://stackoverflow.com/a/29235480/2640551
            
            guard let rootViewController = rootViewController else { return }
            let snapshotView = rootViewController.view.snapshotViewAfterScreenUpdates(true)
            
            self.rootViewController = viewController
            viewController.view.addSubview(snapshotView)
            
            UIView.animateWithDuration(kDefaultAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                snapshotView.alpha = 0.0
            }, completion: { (finished) in
                snapshotView.removeFromSuperview()
            })
        } else {
            self.rootViewController = viewController
        }
    }
}