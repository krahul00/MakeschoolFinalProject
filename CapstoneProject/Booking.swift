//
//  Booking.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/13/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse
class Booking: PFObject,PFSubclassing {
    
    @NSManaged var address: String
    @NSManaged var name: String
    @NSManaged var time: String
    @NSManaged var date: String
    @NSManaged var phoneNumber: String
    
    static func parseClassName() -> String
    {
        return "Booking"
    }
        
}