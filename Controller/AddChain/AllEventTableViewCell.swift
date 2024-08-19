//
//  AllEventTableViewCell.swift
//  SimpleDiary
//
//  Created by Super on 22/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class AllEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Title:UILabel!
    @IBOutlet weak var Event:UILabel!
    @IBOutlet weak var Venue:UILabel!
    @IBOutlet weak var Date:UILabel!
    @IBOutlet weak var CheckBox:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

