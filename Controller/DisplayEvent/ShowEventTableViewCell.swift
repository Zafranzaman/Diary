//
//  ShowEventTableViewCell.swift
//  SimpleDiary
//
//  Created by Super on 15/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ShowEventTableViewCell: UITableViewCell {

    @IBOutlet weak var Repeat:UIButton!
    @IBOutlet weak var did:UILabel!
    @IBOutlet weak var Title:UILabel!
    @IBOutlet weak var Event:UILabel!
    @IBOutlet weak var Venue:UILabel!
    @IBOutlet weak var Date:UILabel!
    @IBOutlet weak var Time:UILabel!
    @IBOutlet weak var Description:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}