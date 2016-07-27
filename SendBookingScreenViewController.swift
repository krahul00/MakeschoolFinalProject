//
//  SendBookingScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/27/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class SendBookingScreenViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var toID: String = ""
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
    let newBookingObject = PFObject(className: "Booking")
        newBookingObject["name"] = nameTextField.text!
        newBookingObject["toID"] = toID
        newBookingObject["date"] = dateTextField.text!
        newBookingObject["time"] = timeTextField.text!
        newBookingObject["phoneNumber"] = phoneNumberTextField.text!
        newBookingObject["address"] = addressTextField.text!
        
        newBookingObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
