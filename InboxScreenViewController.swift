//
//  InboxScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/22/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ParseFacebookUtilsV4

class InboxScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Messages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            findMessages { (result: [PFObject]?, error: NSError?) in
            if let result = result as? [Messages]
            {
                self.messages = result
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath)
        cell.textLabel!.text = messages[indexPath.row].content
        return cell
    }
    
   
    
    func findMessages(completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFQuery(className:"Message")
        query.whereKey("receiverID", equalTo: (PFUser.currentUser()?.username!)!)
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }

    
}
