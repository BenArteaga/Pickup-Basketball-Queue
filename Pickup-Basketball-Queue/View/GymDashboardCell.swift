//
//  GymDashboardCell.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 7/7/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class GymDashboardCell: UITableViewCell {

    @IBOutlet weak var openQueueBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        openQueueBtn.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
