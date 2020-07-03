//
//  AddGymVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class AddGymVC: UIViewController {

    @IBOutlet weak var gymsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

extension AddGymVC: DataServiceDelegate {
    func dataLoaded() {
        gymsTableView.reloadData()
    }
}
extension AddGymVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.gymsToAdd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gym = DataService.instance.gymsToAdd[(indexPath as NSIndexPath).row]
        if let cell = gymsTableView.dequeueReusableCell(withIdentifier: "GymCell") as? GymCell {
            cell.configureGymCell(in_gym: gym)
            return cell
        }
        else {
            return GymCell()
        }
    }
    
    
}
