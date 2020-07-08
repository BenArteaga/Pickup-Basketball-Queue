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
    @IBOutlet weak var courtNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        openQueueBtn.layer.cornerRadius = 10
    }

    func configureCell(in_court: Court) {
        courtNumLabel.text = "Court #: \(in_court.courtNum)"
        if(in_court.queueOpen) {
            openQueueBtn.backgroundColor = .red
            openQueueBtn.titleLabel?.text = "Close Queue"
        }
        else {
            openQueueBtn.backgroundColor = .systemGreen
            openQueueBtn.titleLabel?.text = "Open Queue"
        }
    }

}
