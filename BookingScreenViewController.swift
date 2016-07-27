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

class BookingScreenViewController: UIViewController {
    
    var receiverId: String
     = ""
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        let newMessageObject = PFObject(className: "Message")
        newMessageObject["content"] = self.textField.text!
        newMessageObject["fromID"] = PFUser.currentUser()?.username!
        newMessageObject["receiverID"] = receiverId
        
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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! SendBookingScreenViewController
        destViewController.toID = self.receiverId
    }
}