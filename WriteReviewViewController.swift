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

class WriteReviewViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBAction func review(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    var objectId: String = ""
    var businessName: String = ""
    @IBOutlet weak var textRating: UITextField!
    @IBOutlet weak var numberRating: UITextField!
    var picker: UIPickerView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(WriteReviewViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(WriteReviewViewController.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.mainScreen().bounds.width
        self.picker = UIPickerView(frame: CGRectMake(0,0 , screenWidth,screenHeight * 0.33333))
        self.picker.dataSource = self
        self.picker.delegate = self
        self.numberRating.text! = ""
        self.numberRating.delegate = self

    }
   deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    var categories = ["1", "2", "3", "4", "5"]

    @IBAction func buttonPressed(sender: AnyObject) {
    if ((textRating.text!.isEmpty) || (numberRating.text!.isEmpty))
    {
        let alert = UIAlertView()
        alert.title = "No Text"
        alert.message = "Please Enter Text In All Boxes"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    else
    {
        helperMethod()
        saveReview()
        
    }
    }
    
    func inputPickerDidFinished(){
        self.numberRating.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveReview()
    {
        let object = PFObject(className: "Review")
        object["content"] = self.textRating.text!
        object["fromID"] = PFUser.currentUser()!["username"]
        object["toID"] = businessName
     //   object["reviewNumber"] = numberRating.text!
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
                result.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        // The object has been saved.
                    } else {
                        print (error)
                    }
        }
    
    
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return categories.count
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: categories[row])
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberRating.text = categories[row]
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.pickUpDate()
    }
    func pickUpDate(){
        let toolBar = UIToolbar(frame: CGRectMake(0,0,320,44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(FourthSignUpScreen.inputPickerDidFinished))
        toolBar.setItems([doneButton], animated: false)
        self.numberRating.inputView = picker
        self.numberRating.inputAccessoryView = toolBar
    }


}

