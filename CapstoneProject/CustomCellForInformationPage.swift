//
//  CustomCellForInformationPage.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 8/2/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit

class CustomCellForInformationPage: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
