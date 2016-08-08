//
//  MessagingScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/22/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Foundation

class MessagingScreenViewController: UIViewController, UITableViewDataSource  {
    
    var bookings: [Booking] = []


    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return bookings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }

    
}
