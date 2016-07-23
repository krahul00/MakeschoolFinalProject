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

class InboxScreenViewController: UIViewController, UITableViewDelegate
{

    var messages: [String] = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("MessageCell")
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages.count
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
