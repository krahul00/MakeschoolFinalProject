//
//  CustomCell.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/26/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import ParseUI

class CustomCellForBooking: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UILabel!
   
    @IBOutlet weak var addressTextField: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
