//
//  InformationPageViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/2/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse

class InformationPageViewController: UIViewController, UITableViewDataSource {
    
    var user: User!
    
    var reviews: [Review] = []
    
    var objectId1: String = ""

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func information(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessName.text! = user.businessName
        priceLabel.text! = user.price1
        descriptionLabel.text! = user.content1
        requestForReviews(user.businessName) { (result, error: NSError?) in
            if let result = result as? [Review]
            {
                self.reviews = result
                self.tableView.reloadData()
            } else {
                
            }
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewCell", forIndexPath: indexPath) as! CustomCellForInformationPage
        cell.userName.text! = reviews[indexPath.row].fromID
        cell.content.text! = reviews[indexPath.row].content
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reviews.count
    }
    
    func requestForReviews(string: String, completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFQuery(className: "Review")
        query.whereKey("fromID", equalTo: string)
        query.limit = 5
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "InformationToReview")
        {
            let destViewController = segue.destinationViewController as! WriteReviewViewController
            destViewController.objectId = objectId1
            destViewController.businessName = user.businessName
        }
        if (segue.identifier == "InformationToMessage")
        {
            let destViewController = segue.destinationViewController as! MessagingScreenViewController
            destViewController.receiverId = user.businessName
        }
        if (segue.identifier == "InformationToBooking")
        {
            let destViewController = segue.destinationViewController as! FirstBookingScreenViewController
            destViewController.toID = user.businessName
        }
    }
}
