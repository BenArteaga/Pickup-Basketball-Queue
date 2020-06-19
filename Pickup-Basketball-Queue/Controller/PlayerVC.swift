//
//  PlayerVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/19/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

    @IBOutlet weak var playerQueue: UITableView!
    @IBOutlet weak var getOnQueueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOnQueueBtn.layer.cornerRadius = 10
    }

}
