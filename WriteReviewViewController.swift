//
//  WriteReviewViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/2/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class WriteReviewViewController: UIViewController, UIScrollViewDelegate {
    
    @IBAction func review(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    var objectId: String = ""
    var businessName: String = ""
    @IBOutlet weak var textRating: UITextField!
    @IBOutlet weak var numberRating: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(WriteReviewViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(WriteReviewViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
   deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    }


    @IBAction func buttonPressed(sender: AnyObject) {
        helperMethod()
        saveReview()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveReview()
    {
        let object = PFObject(className: "Review")
        object["content"] = self.textRating
        object["fromID"] = PFUser.currentUser()!["username"]
        object["toID"] = businessName
        object["reviewNumber"] = numberRating
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                print (error)
            }
        }
        
    }
    
    func helperMethod()
    {
        let query = PFUser.query()
        query?.getObjectInBackgroundWithId(objectId, block: { (result: PFObject?, error: NSError?) -> Void in
            if error != nil
            {
                print (error)
            }
            else if let result = result

            {
                let previousAverageReview: Int = result["averageReview"] as! Int
                let previousNumberOfRating: Int = result["numberOfRating"] as! Int
                let realNumberRating: Int = Int(self.numberRating.text!)!
                result["averageReview"] = ((previousAverageReview * previousNumberOfRating) + realNumberRating)/(previousNumberOfRating + 1)
                result["numberOfRating"] = previousNumberOfRating + 1
            }
        })
    
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
