//
//  SignInViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/19/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
         super.viewDidLoad()
         NSNotificationCenter.defaultCenter().addObserver(self,
         selector: #selector(SignInViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self,
         selector: #selector(SignInViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
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
                    let main : UIViewController = storyboard1.instantiateViewControllerWithIdentifier("HomeScreenOfBusiness") as UIViewController!
                    self.presentViewController(main, animated: true, completion: nil)
                    
                    
                } else {
                    let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeScreen") as UIViewController!
                    self.presentViewController(mainVC, animated: true, completion: nil)
                }
                
            }
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