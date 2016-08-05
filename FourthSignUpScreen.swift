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
import CoreLocation

class FourthSignUpScreen: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate, CLLocationManagerDelegate {
    
    var firstName: String = ""
    var lastName: String = ""
    var username: String = ""
    var businessName = ""
    var businessPhoneNumber = ""
    var isBusiness: Bool = false
    var password = ""
    var currentUserLocation: PFGeoPoint!
    let locationManager = CLLocationManager()
    
    @IBAction func fourthButton(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var priceOne: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var descriptionOne: UITextField!
    @IBOutlet var picker: UIPickerView!
    var categories = ["Cleaning", "Plumbing", "Electrical", "Events", "Catering", "Landscaping"]

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(FourthSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(FourthSignUpScreen.keyboardWillShowOrHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.mainScreen().bounds.width
        self.picker = UIPickerView(frame: CGRectMake(0,0 , screenWidth,screenHeight * 0.33333))
        self.picker.dataSource = self
        self.picker.delegate = self
        self.typeTextField.text! = ""
        self.typeTextField.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }

    }
    
    func inputPickerDidFinished(){
        self.typeTextField.resignFirstResponder()
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
    
   func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
   {
        let userLocation:CLLocation = locations[0] 
        currentUserLocation = PFGeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
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
        user.username = username
        user["businesssName"] = businessName
        user["businessPhoneNumber"] = businessPhoneNumber
        user["type"] = typeTextField.text!
        user["content1"] = descriptionOne.text!
        user["price1"] = priceOne.text!
        user["location"] = currentUserLocation
        user["averageReview"] = ("0")
        user["numberOfRating"] = ("0")
            user.signUpInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            guard error == nil else
            {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue())
            {
            let storyboard = UIStoryboard(name: "BusinessStoryboard", bundle: nil)
            let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeScreenOfBusiness") as UIViewController!
            self.presentViewController(mainVC, animated: true, completion: nil)
            }
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
        typeTextField.text = categories[row]
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
        self.typeTextField.inputView = picker
        self.typeTextField.inputAccessoryView = toolBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
}
