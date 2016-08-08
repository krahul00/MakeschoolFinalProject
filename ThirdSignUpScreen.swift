//
//  ThirdSignUpScreen.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/29/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit

class ThirdSignUpScreen: UIViewController, UIScrollViewDelegate {
    
    var firstName: String = ""
    var lastName: String = ""
    var username: String = ""
    var isBusiness: Bool = false
    var password = ""
    
    @IBAction func thirdBackButton(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var businessNameTextField: UITextField!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var businessPhoneNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(ThirdSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(ThirdSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "FirstToSecond" {
            
            if ((businessNameTextField.text!.isEmpty) || (businessPhoneNumberTextField.text!.isEmpty)){
                
                let alert = UIAlertView()
                alert.title = "No Text"
                alert.message = "Please Enter Text In The Box"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
                
            else {
                return true
            }
        }
        return true
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ThirdToFourth")
        {
        let destViewController = segue.destinationViewController as! FourthSignUpScreen
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.username = username
        destViewController.isBusiness = isBusiness
        destViewController.businessName = businessNameTextField.text!
        destViewController.businessPhoneNumber = businessPhoneNumberTextField.text!
        destViewController.password = password
        }
        
    }


}
