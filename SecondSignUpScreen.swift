//
//  SignUpForBusinessViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/21/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class SecondSignUpScreen: UIViewController, UIScrollViewDelegate{
    
    var firstName: String = ""
    var lastName: String = ""
    var isBusiness: Bool = false
    
    @IBAction func performSegueButton(sender: AnyObject) {
        if (self.isBusiness == false)
        {
            performSegueWithIdentifier("SecondToHome", sender: sender)
        }
        else {
            performSegueWithIdentifier("SecondToThird", sender: sender)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(SecondSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(SecondSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
   
    
    func signUpHelperMethod()
    {
        let user = PFUser()
        user["name"] = firstName + "" + lastName
        user.password = passwordTextField.text!
        user["isBusiness"] = false
        user["email"] = emailTextField.text!
        
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SecondToThird")
        {
        let destViewController = segue.destinationViewController as! ThirdSignUpScreen
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.email = emailTextField.text!
        destViewController.isBusiness = isBusiness
        destViewController.password = passwordTextField.text!
        }
        else
        {
            signUpHelperMethod()
        }
        
    }
    //MARK: KEYBOARD SCROLL CONNECTION
    
    func keyboardWillShowOrHide(notification: NSNotification) {
        
        if let scrollView = scrollView, userInfo = notification.userInfo, endValue = userInfo[UIKeyboardFrameEndUserInfoKey], durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey], curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] {
            scrollView.keyboardDismissMode = .Interactive
            let endRect = view.convertRect(endValue.CGRectValue, fromView: view.window)
            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            scrollView.contentInset.bottom = keyboardOverlap
            scrollView.scrollIndicatorInsets.bottom = keyboardOverlap
            let duration = durationValue.doubleValue
            let options = UIViewAnimationOptions(rawValue: UInt(curveValue.integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }



}
