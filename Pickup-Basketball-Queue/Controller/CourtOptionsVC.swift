//
//  CourtOptionsVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class CourtOptionsVC: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
