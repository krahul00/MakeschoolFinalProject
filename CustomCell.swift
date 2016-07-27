//
//  CustomCell.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/26/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import ParseUI

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
