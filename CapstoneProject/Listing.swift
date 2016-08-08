//
//  Listing.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/12/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bond

class Client: PFObject, PFSubclassing
{
    // 2
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    
    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "Post"
    }
    
    // 4
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
}