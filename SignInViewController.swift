//
//  SignInViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/19/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func login(sender: AnyObject) {
        logIn()
    }
    
    func logIn()
    {
        let user = PFUser()
        
        // ADD VALIDATION
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        PFUser.logInWithUsernameInBackground(user.username!, password: user.password!) { user, error in
            guard error == nil else
            {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue())
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let storyboard1 = UIStoryboard(name: "BusinessStoryboard", bundle: nil)
                if (user!["isBusiness"] as! Bool) == true
                {
                    let mainVC : UIViewController = storyboard1.instantiateViewControllerWithIdentifier("BusinessInboxScreen") as UIViewController!
                    self.presentViewController(mainVC, animated: true, completion: nil)


                } else {
                    let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeScreen") as UIViewController!
                    self.presentViewController(mainVC, animated: true, completion: nil)
                }
                
            }
}
}
}