//
//  testdisplayTableViewCell.swift
//  SimpleDiary
//
//  Created by Super on 02/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class testdisplayTableViewCell: UITableViewCell {
    @IBOutlet weak var Name:UILabel!
    @IBOutlet weak var Date:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
