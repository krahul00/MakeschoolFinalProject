import UIKit
import ParseUI
import CoreLocation

class BusinessListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var businesses: [PFUser] = []
    var category: String!
    let locationManager = CLLocationManager()
    var currUserGeoPoint: PFGeoPoint!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReuseIdentifier", forIndexPath: indexPath)
        cell.textLabel!.text = businesses[indexPath.row].username
        return cell
    }
    
    func requestForSpecificCategory(type: String, location: PFGeoPoint, completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFUser.query()!
        query.whereKey("isBusiness", equalTo:true)
        query.whereKey("location", nearGeoPoint: location, withinMiles: 1000000)
        query.whereKey("type", equalTo: type)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
 
 
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { 
        guard let location = locations.first else { return }
        currUserGeoPoint = PFGeoPoint(location: location)
        requestForSpecificCategory(category!, location: currUserGeoPoint) { (result: [PFObject]?, error: NSError?) in
            
            print (result)
            
            if let result = result as? [PFUser]
            {
                self.businesses = result
                self.tableView.reloadData()
            } else {
                //print alert
            }
        }
    }

 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! BookingScreenViewController
        destViewController.receiverId = businesses[tableView.indexPathForSelectedRow!.row].username!
    }

}
 