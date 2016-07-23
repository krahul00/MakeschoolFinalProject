//
//  ParseHelper.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/13/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class ParseHelper
{
    static func requestForSpecificCategory(type: String, completionBlock: PFQueryArrayResultBlock)
    {
        let query = PFQuery(className: "Business")
        query.whereKey("Type", equalTo: type)
    }
}
