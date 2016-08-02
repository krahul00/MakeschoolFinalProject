//
//  User.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/2/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse

class User: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var isBusiness: Bool
    @NSManaged var location: PFGeoPoint
    @NSManaged var username: String
    @NSManaged var type: String
    @NSManaged var password: String
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var averageReview: Int
    @NSManaged var businessName: String
    @NSManaged var businessPhoneNumber: String
    
    
    static func parseClassName() -> String
    {
        return "Message"
    }
    override class func initialize(){
        var onceToken : dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
            
        }
    }
}