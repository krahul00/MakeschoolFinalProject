//
//  CustomCellForBusinessList.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/1/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit

class CustomCellForBusinessList: UITableViewCell {

    @IBOutlet weak var reviewAverage: UILabel!
    @IBOutlet weak var businessName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
