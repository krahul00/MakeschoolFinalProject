//
//  BookingScreenForBusinessViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/26/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class BookingScreenForBusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var bookings: [Booking] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findBookings { (result: [PFObject]?, error: NSError?) in
            
            print(result)
            
            if let result = result as? [Booking]
            {
                
        
                self.bookings = result
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }
    }
    
    @IBAction func signOut(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Confirm log out", message: "Are you sure you want to log out", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Log out", style: .Destructive, handler: { (action: UIAlertAction) in
            alert.dismissViewControllerAnimated(true, completion: nil)
            PFUser.logOutInBackgroundWithBlock{ (error: NSError?) -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.loginSetup()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {(action: UIAlertAction) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)

         
    }
    
    func loginSetup()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeScreen = storyboard.instantiateViewControllerWithIdentifier("LaunchScreen")
        self.presentViewController(homeScreen, animated: true, completion: nil)
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.window?.rootViewController = homeScreen
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bookings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookingCell", forIndexPath: indexPath) as! CustomCellForBooking
        cell.addressTextField.text = bookings[indexPath.row].address
        cell.nameTextField.text = bookings[indexPath.row].name
        cell.time.text = bookings[indexPath.row].time
        cell.date.text = bookings[indexPath.row].date
        cell.phoneNumber.text = bookings[indexPath.row].phoneNumber
       
        return cell
    }
    
    func findBookings(completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFQuery(className:"Booking")
        query.whereKey("toID", equalTo: (PFUser.currentUser()!["businessName"])!)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
}
