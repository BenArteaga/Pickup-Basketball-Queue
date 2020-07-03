//
//  GymCell.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class GymCell: UITableViewCell {

    @IBOutlet weak var gymNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureGymCell(in_gym: Gym) {
        gymNameLabel.text = in_gym.gymName
    }

}
