//
//  QueueCell.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/22/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Kingfisher

class QueueCell: UITableViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var queuePositionLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        playerImg.layer.cornerRadius = 10
    }
    
    func configureCell(in_player: Player) {
        playerNameLabel.text = in_player.playerName
        queuePositionLabel.text = "\(in_player.queuePosition ?? -1)"
        let imageUrl = URL(string: in_player.imagePath)
        playerImg.kf.setImage(with: imageUrl)
    }

}
