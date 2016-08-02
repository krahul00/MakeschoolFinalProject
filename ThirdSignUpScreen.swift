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
    var email: String = ""
    var isBusiness: Bool = false
    var password = ""
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! FourthSignUpScreen
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.email = email
        destViewController.isBusiness = isBusiness
        destViewController.businessName = businessNameTextField.text!
        destViewController.businessPhoneNumber = businessPhoneNumberTextField.text!
        destViewController.password = password
        
    }


}
