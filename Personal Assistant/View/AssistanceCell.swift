//
//  AssistanceCell.swift
//  PersonalAssistant
//
//  Created by Mohamad Khan on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit

class AssistanceCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!

    func updateViews(assistance: Assistance){
        cellImage.image = UIImage(named: assistance.imageName)
        cellTitle.text = assistance.title
    }

}
