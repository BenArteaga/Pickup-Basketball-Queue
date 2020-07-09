//
//  GymDashboardVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 7/8/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class GymDashboardVC: UIViewController {

    @IBOutlet weak var courtsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courtsTableView.delegate = self
        courtsTableView.dataSource = self
        
        CourtService.instance.loadCourts() { (success) in
            DispatchQueue.main.async {
                self.courtsTableView.reloadData()
            }
        }

    }
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        do {
            try Firebase.Auth.auth().signOut()
            AuthService.instance.isLoggedIn = false
            performSegue(withIdentifier: "GymDashboardViewtoSignInView", sender: nil)
        } catch {
            print("An error occured signing out")
        }
    }
    
}

extension GymDashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourtService.instance.courts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let court = CourtService.instance.courts[indexPath.row]
        if let cell = courtsTableView.dequeueReusableCell(withIdentifier: "GymDashboardCell") as? GymDashboardCell {
            cell.indexPathForCell = indexPath
            cell.configureCell(in_court: court)
            return cell
        }
        else {
            return GymDashboardCell()
        }
    }
}
