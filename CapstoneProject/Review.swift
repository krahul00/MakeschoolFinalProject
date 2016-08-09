//
//  Review.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/3/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse

class Review: PFObject, PFSubclassing {
    
    @NSManaged var fromID: String
    @NSManaged var toID: String
    @NSManaged var content: String
    
    static func parseClassName() -> String
    {
        return "Review"
    }
   
}