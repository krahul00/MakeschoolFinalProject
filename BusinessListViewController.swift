import UIKit
import ParseUI
import Parse
import CoreLocation

class BusinessListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var businesses: [User] = []
    var category: String!
    var locationManager = CLLocationManager()
    var currUserGeoPoint: PFGeoPoint!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currUserGeoPoint)
        
        /*locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         
         if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
         locationManager.requestWhenInUseAuthorization()
         } else {
         locationManager.startUpdatingLocation()
         }
         }
         
         
         */ 
        
        requestForSpecificCategory(category!, location: currUserGeoPoint) { (result: [PFObject]?, error: NSError?) in
            print(self.currUserGeoPoint)
            if result?.count != 0
            {
                self.businesses.removeAll()
                for user in result! {
                    let user = user as! User
                    self.businesses.append(user)
                }
              self.tableView.reloadData()
                //self.locationManager.stopUpdatingLocation()
            } else {
                //print
            }
            
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! CustomCellForBusinessList
        cell.businessName.text! = businesses[indexPath.row].businessName
        if (businesses[indexPath.row].averageReview == 0)
        {
            cell.reviewAverage.text! = "No Reviews"
            
        }
        else
        {
            cell.reviewAverage.text! = (String(businesses[indexPath.row].averageReview) + " Stars")
        }
        return cell
    }
    
    func requestForSpecificCategory(type: String, location: PFGeoPoint, completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFUser.query()!
        query.whereKey("isBusiness", equalTo: true)
        query.whereKey("location", nearGeoPoint: location, withinMiles: 100)
        query.whereKey("type", equalTo: type)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    //func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
     //   print(error)
    //}
    
    
    @IBAction func stscreenprssed(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*func locationManager(manager: CLLocationManager!,   didUpdateLocations locations: [AnyObject]!) {
     let locValue:CLLocationCoordinate2D = manager.location!.coordinate
     currUserGeoPoint = PFGeoPoint(latitude: locValue.latitude, longitude: locValue.longitude)
     }
     
     func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     guard let location = locations.first else { return }
     currUserGeoPoint = PFGeoPoint(location: location)
     requestForSpecificCategory(category!, location: currUserGeoPoint) { (result: [PFObject]?, error: NSError?) in
     if result?.count != 0
     {
     self.businesses.removeAll()
     for user in result! {
     let user = user as! User
     self.businesses.append(user)
     }
     self.tableView.reloadData()
     self.locationManager.stopUpdatingLocation()
     } else {
     //print
     }
     
     }
     }
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ListToInformation")
        {
            let destViewController = segue.destinationViewController as! InformationPageViewController
            destViewController.user = businesses[tableView.indexPathForSelectedRow!.row]
            destViewController.objectId1 = businesses[tableView.indexPathForSelectedRow!.row].objectId!
        }
        
    }
    
}
 