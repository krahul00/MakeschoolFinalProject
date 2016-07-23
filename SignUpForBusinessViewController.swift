//
//  SignUpForBusinessViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/21/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class SignUpForBusinessViewController: UIViewController {
    
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        signUpHelperMethod()
    }
    
    
    func signUpHelperMethod()
    {
        /** let business = PFUser()
         business.name =
         business.username = usernameTextField.text!
         business.password = passwordTextField.text!
         Business.signUpInBackgroundWithBlock { (succeeded, error) in
         guard error == nil else
         {
         print(error)
         return
         }
         dispatch_async(dispatch_get_main_queue())
         {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeScreen") as UIViewController!
         self.presentViewController(mainVC, animated: true, completion: nil)
         }
         
         }
         */
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user["type"] = typeTextField.text!
        user["name"] = businessNameTextField.text!
        user["isBusiness"] = true
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
            guard error == nil else
            {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue())
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeScreen") as UIViewController!
                self.presentViewController(mainVC, animated: true, completion: nil)
            }
        }

}
}
