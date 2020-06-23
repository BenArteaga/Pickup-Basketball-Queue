//
//  QueueCell.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/22/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class QueueCell: UITableViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var queuePositionLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        playerImg.layer.cornerRadius = 10
    }
    
    func configureCell(player: Player) {
        playerNameLabel.text = player.playerName
        queuePositionLabel.text = "\(String(describing: player.queuePosition))"
        playerImg.image = DataService.instance.imageForPath(player.imagePath)
    }

}
