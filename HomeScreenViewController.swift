//
//  HomeScreenViewController.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/13/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import Foundation


class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var introductoryMessage: UILabel!
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindFromBookToHome(segue: UIStoryboardSegue)
    {
        
    }
    @IBAction func unwindFromMessageToHome(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindFromReviewToHome(segue: UIStoryboardSegue)
    {
        
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
    
            
 
    var location: PFGeoPoint!
    
    var categories = ["Cleaning", "Plumbing", "Electrical", "Events", "Catering", "Landscaping"]
    var imageList = [UIImage(named: "Cleaning Icon.png"), UIImage(named: "Plumbing Icon.png"), UIImage(named: "Electricity Icon.png"), UIImage(named: "Events Icon.png"), UIImage(named: "Catering Icon.png"), UIImage(named: "Landscaping Icon.png"),]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (PFUser.currentUser() != nil)
        {
        let string1 = PFUser.currentUser()!["firstName"]
        introductoryMessage.text! = "Hi, \(string1)."
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        }
    }

    
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startMonitoringSignificantLocationChanges()
//        locationManager.startUpdatingLocation()

    

        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRowAtIndexPath(indexPath,animated: false)
        }
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
    
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) 
    {
        let userLocation:CLLocation = locations[0]
        location = PFGeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        print(location)
        
    }

    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! BusinessListViewController
        destViewController.category = categories[tableView.indexPathForSelectedRow!.row]
             print(location)
        destViewController.currUserGeoPoint = location
            locationManager.stopUpdatingLocation()
            
        
    }
}