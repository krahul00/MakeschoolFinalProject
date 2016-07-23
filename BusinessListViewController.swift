//
//  BusinessListViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/11/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import ParseUI

class BusinessListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var businesses: [Business] = []
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        requestForSpecificCategory(category!) { (result: [PFObject]?, error: NSError?) in
            print(result)
            if let result = result as? [Business]
            {
                self.businesses = result
                self.tableView.reloadData()
            }
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // 1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        print ("2")
        let cell = tableView.dequeueReusableCellWithIdentifier("ReuseIdentifier", forIndexPath: indexPath)
        print("1")
        cell.textLabel!.text = businesses[indexPath.row].name
        print ("3")
        return cell
    }
    
    func requestForSpecificCategory(type: String, completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFQuery(className: "Business")
//        query.whereKey("Type", equalTo: type)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
}