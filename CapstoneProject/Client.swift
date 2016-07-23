//
//  Client.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/19/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import Parse
class Client: PFUser {
    
    @NSManaged var name:String?
    
    override class func initialize()
    {
        var onceToken : dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
}