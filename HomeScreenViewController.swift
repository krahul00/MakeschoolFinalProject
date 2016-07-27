//
//  HomeScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/13/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = ["Housekeeping", "Landscaping", "Handymen"]

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("ReuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! BusinessListViewController
        print ("Segue is happ")
        destViewController.category = categories[tableView.indexPathForSelectedRow!.row]
        
    }
}