//
//  HomeScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/13/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import Foundation


class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var introductoryMessage: UILabel!
    
    var categories = ["Cleaning", "Plumbing", "Electrical", "Events", "Catering", "Landscaping"]
    var imageList = [UIImage(named: "Cleaning Icon.png"), UIImage(named: "Plumbing Icon.png"), UIImage(named: "Electricity Icon.png"), UIImage(named: "Events Icon.png"), UIImage(named: "Catering Icon.png"), UIImage(named: "Landscaping Icon.png"),]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let string1 = PFUser.currentUser()!["firstName"]
        introductoryMessage.text! = "Hi, \(string1)."
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReuseIdentifier", forIndexPath: indexPath) as! CustomCellForHomeScreen
        cell.categoryName.text = categories[indexPath.row]
        cell.imageView1.image = imageList[indexPath.row]
        return cell
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! BusinessListViewController
        destViewController.category = categories[tableView.indexPathForSelectedRow!.row]
        
    }
}