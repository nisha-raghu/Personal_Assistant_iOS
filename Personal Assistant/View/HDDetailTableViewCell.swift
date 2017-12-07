//
//  SCDetailTableViewCell.swift
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit

class HDDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
