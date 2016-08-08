//
//  CustomCellForMessages.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/3/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit

class CustomCellForMessages: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
