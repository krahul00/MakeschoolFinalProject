//
//  BookingScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/22/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

/**import UIKit
import ParseFacebookUtilsV4
import ParseUI
import Parse

class BookingScreenViewController: UIViewController {

    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let newMessageObject = PFObject(className: "Message")
        newMessageObject["Text"] = self.message.text!
        newMessageObject.saveInBackgroundWithBlock { (success, error) in
            if (success = true)
            {
                
            }
                else
            {
                print (error)
            }
        }
        
        
        
    }
    
    @IBOutlet weak var message: UITextField!
    
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

}*/
