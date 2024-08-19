//
//  ExampleTableViewCell.swift
//  SimpleDiary
//
//  Created by Super on 07/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {
    @IBOutlet weak var Name:UILabel!
    @IBOutlet weak var Date:UILabel!
    @IBOutlet weak var Event:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
