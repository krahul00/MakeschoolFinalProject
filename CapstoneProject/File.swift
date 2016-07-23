import Foundation
import Parse


class ParseHelper
{
    static func timelineRequestForCurrentUser(completionBlock: PFQueryArrayResultBlock, type: String)
    {
        var array: [String] = [String]()
        var query = PFQuery(className: "Business")
        
        func loadData() {
            
            query.orderByAscending("column")
            
            query.findObjectsInBackgroundWithBlock{ (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            self.array.append(object.objectForKey("column") as! String)
                        }
                    }
        }
    }
    
}