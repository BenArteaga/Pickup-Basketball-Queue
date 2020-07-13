//
//  CourtOptionsVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class CourtOptionsVC: UIViewController {
    
    @IBOutlet weak var courtsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        courtsTableView.delegate = self
        courtsTableView.dataSource = self
        
        CourtService.instance.loadCourtsForGym() { (success) in
            DispatchQueue.main.async {
                self.courtsTableView.reloadData()
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
    }
    
}

extension CourtOptionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourtService.instance.courts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let court = CourtService.instance.courts[indexPath.row]
        if let cell = courtsTableView.dequeueReusableCell(withIdentifier: "CourtCell") as? CourtCell {
            cell.configureCell(in_court: court)
            return cell
        }
        else {
            return CourtCell()
        }
    }
}
