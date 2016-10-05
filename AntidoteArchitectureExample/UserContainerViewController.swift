//
//  UserContainerViewController.swift
//  AntidoteArchitectureExample
//
//  Created by Dima on 20/09/16.
//  Copyright © 2016 Dmitry Utmanov. All rights reserved.
//

import UIKit

class UserContainerViewController: UIViewController {

    @IBOutlet weak var usersContainerView: UIView!
    @IBOutlet weak var userContainerView: UIView!
    
    var usersViewControllerBuilder: () -> (UsersTableViewControllerProtocol) = {
        closureFatalError()
    }
    
    var userViewControllerBuilder: (String) -> (UserViewController) = { _ in
        closureFatalError()
    }
    
    func updateUserViewController(_ name: String) {
        if let userViewController = userViewController {
            let newUserViewController = userViewControllerBuilder(name)
            exchangeContentController(fromContentController: userViewController, toContentController: newUserViewController, inView: userContainerView, animated: true)
            self.userViewController = newUserViewController
        } else {
            userViewController = userViewControllerBuilder(name)
            displayContentController(userViewController!, inView: userContainerView, animated: true)
        }
    }
    
    weak var usersViewControllerProtocol: UsersTableViewControllerProtocol?
    weak var userViewController: UserViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usersViewControllerProtocol = usersViewControllerBuilder()
        displayContentController(usersViewControllerProtocol!.viewController()!, inView: usersContainerView, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
