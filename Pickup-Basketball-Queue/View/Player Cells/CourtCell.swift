//
//  CourtCell.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class CourtCell: UITableViewCell {

    @IBOutlet weak var courtNumLabel: UILabel!
    @IBOutlet weak var queueSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(in_court: Court) {
        courtNumLabel.text = "Court Num: \(in_court.courtNum)"
        if in_court.queueOpen {
            queueSizeLabel.text = "Queue Size: \(in_court.queue.count)"
            queueSizeLabel.textColor = .systemGreen
        }
        else {
            queueSizeLabel.text = "Queue is closed"
            queueSizeLabel.textColor = .red
        }
    }

}
