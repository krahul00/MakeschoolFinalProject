//
//  SignUpForUserViewController.swift
//
//
//  Created by Rahul Mehta on 7/21/16.
//
//

import UIKit
import Parse
import Bolts

class SignUpForUserViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signUp(sender: AnyObject) {
        signUpHelperMethod()
    }
    
    func signUpHelperMethod()
    {
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        user["isBusiness"] = false
        
        
        user.signUpInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
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
