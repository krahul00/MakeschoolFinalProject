//
//  Message.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/25/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse

class Messages: PFObject,PFSubclassing {
    
    @NSManaged var content: String
    @NSManaged var receiverID: String
    @NSManaged var fromID: String
    
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