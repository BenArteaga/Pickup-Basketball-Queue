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
    var indexPathForCell: IndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        openQueueBtn.layer.cornerRadius = 10
    }

    func configureCell(in_court: Court) {
        courtNumLabel.text = "Court #: \(in_court.courtNum)"
        if(in_court.queueOpen) {
            openQueueBtn.backgroundColor = .red
            openQueueBtn.setTitle("Close queue", for: .normal)
        }
        else {
            openQueueBtn.backgroundColor = .systemGreen
            openQueueBtn.setTitle("Open Queue", for: .normal)
        }
    }

    @IBAction func openQueueBtnPressed(_ sender: UIButton) {
        if openQueueBtn.backgroundColor == .red {
            CourtService.instance.updateQueueStatus(isClosed: false, courtNum: indexPathForCell.row)
            openQueueBtn.backgroundColor = .systemGreen
            openQueueBtn.setTitle("Open queue", for: .normal)
        }
        else {
            CourtService.instance.updateQueueStatus(isClosed: true, courtNum: indexPathForCell.row)
            openQueueBtn.backgroundColor = .red
            openQueueBtn.setTitle("Close Queue", for: .normal)
        }
    }
}
