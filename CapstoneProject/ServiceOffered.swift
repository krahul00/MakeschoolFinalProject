//
//  ServiceOffered.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/30/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse
class ServiceOffered: PFObject,PFSubclassing {
    
    @NSManaged var price: String
    @NSManaged var fromBusiness: String
    @NSManaged var whichBusiness: String
    static func parseClassName() -> String
    {
        return "ServiceOffered"
    }
    override class func initialize(){
        var onceToken : dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
            
        }
    }
}