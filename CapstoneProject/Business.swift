//
//  Business.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/13/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse
class Business: PFObject,PFSubclassing {
    
    @NSManaged var type: String
    @NSManaged var name: String
    
    static func parseClassName() -> String
    {
        return "Business"
    }
    override class func initialize(){
        var onceToken : dispatch_once_t = 0
        dispatch_once(&onceToken) { 
            self.registerSubclass()
            
        }
    }
}