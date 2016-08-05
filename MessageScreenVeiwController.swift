//
//  BookingScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/22/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import ParseUI
import Parse

class MessagingScreenViewController: UIViewController, UIScrollViewDelegate{
    
    @IBAction func message(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var receiverId: String
     = ""
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        let newMessageObject = PFObject(className: "Message")
        newMessageObject["content"] = self.textField.text!
        newMessageObject["fromID"] = PFUser.currentUser()?.username!
        newMessageObject["receiverID"] = receiverId
        newMessageObject["phoneNumber"] = phoneNumber
        
        newMessageObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if (success == true)
            {
                print("it was a success")
                
            }
            else
            {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(MessagingScreenViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(MessagingScreenViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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