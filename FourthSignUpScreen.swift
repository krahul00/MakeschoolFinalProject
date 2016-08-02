//
//  FourthSignUpScreen.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/29/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FourthSignUpScreen: UIViewController, UIPickerViewDelegate, UIScrollViewDelegate, UIPickerViewDataSource {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var businessName = ""
    var businessPhoneNumber = ""
    var isBusiness: Bool = false
    var password = ""
   
    @IBOutlet weak var priceOne: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var picker = UIPickerView()
    @IBOutlet weak var descriptionOne: UITextField!
    @IBOutlet weak var priceTwo: UITextField!
    @IBOutlet weak var descriptionTwo: UITextField!
    @IBOutlet weak var priceThree: UITextField!
    @IBOutlet weak var descriptionThree: UITextField!
    
    var categories: [String] = ["Cleaning", "Plumbing", "Electrical", "Events", "Catering", "Landscaping"]

    override func viewDidLoad() {
        super.viewDidLoad()
            NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(FourthSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(FourthSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        picker?.removeFromSuperview()
        picker!.hidden = true
        typeTextField.text! = ""
        typeTextField.inputView = picker
        picker?.dataSource = self
        picker?.delegate = self

        
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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

    @IBAction func buttonPressed(sender: AnyObject) {
         signUpHelperMethod()
    }
    
    func signUpHelperMethod() {
        let user = PFUser()
        user["firstName"] = firstName
        user["lastName"] = lastName
        user["name"] = firstName + "" + lastName
        user.password = password
        user["isBusiness"] = true
        user["email"] = email
        user["businesssName"] = businessName
        user["businessPhoneNumber"] = businessPhoneNumber
        user["type"] = typeTextField.text!
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
        if (priceOne.text != nil && descriptionOne != nil)
        {
            let serviceOffered = PFObject(className: "ServiceOffered")
            serviceOffered["price"] = priceOne
            serviceOffered["description"] = descriptionOne
            
            serviceOffered.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
                guard error == nil else
                {
                    print (error)
                    return
                }

            }
        }
        if (priceTwo.text != nil && descriptionTwo != nil)
        {
            let serviceOffered = PFObject(className: "ServiceOffered")
            serviceOffered["price"] = priceTwo
            serviceOffered["description"] = descriptionTwo
            
            serviceOffered.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
                guard error == nil else
                {
                    print (error)
                    return
                }
                
            }
        }
        if (priceTwo.text != nil && descriptionTwo != nil)
        {
            let serviceOffered = PFObject(className: "ServiceOffered")
            serviceOffered["price"] = priceTwo
            serviceOffered["description"] = descriptionTwo
            
            serviceOffered.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
                guard error == nil else
                {
                    print (error)
                    return
                }
                
            }
        }
        dispatch_async(dispatch_get_main_queue())
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeScreenOfBusiness") as UIViewController!
            self.presentViewController(mainVC, animated: true, completion: nil)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = categories[row]
        picker!.hidden = true;
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        picker!.hidden = false
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
}
