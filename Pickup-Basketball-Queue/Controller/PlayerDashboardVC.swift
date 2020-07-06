//
//  PlayerDashboardVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class PlayerDashboardVC: UIViewController {

    @IBOutlet weak var addGymBtn: UIButton!
    
    //View of all the gyms that the player has added to their dashboard
    @IBOutlet var playerGymsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.instance.delegate = self
        
        playerGymsTableView.delegate = self
        playerGymsTableView.dataSource = self

        addGymBtn.layer.cornerRadius = 10
        
        DataService.instance.loadGymsFollowing { (gyms) in
            self.playerGymsTableView.reloadData()
        }
    }
    
    @IBAction func addGymBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "PlayerDashboardViewtoAddGymView", sender: nil)
    }
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        do {
            try Firebase.Auth.auth().signOut()
            AuthService.instance.isLoggedIn = false
            performSegue(withIdentifier: "PlayerDashboardViewtoSignInView", sender: nil)
        } catch {
            print("An error occured signing out")
        }
    }
    
}

extension PlayerDashboardVC: DataServiceDelegate {
    func dataLoaded() {
        playerGymsTableView.reloadData()
    }
}

extension PlayerDashboardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.gymsFollowing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let gym = DataService.instance.gymsFollowing[(indexPath as NSIndexPath).row]
        if let cell = playerGymsTableView.dequeueReusableCell(withIdentifier: "PlayerDashboardCell") as? PlayerDashboardCell {
            cell.configureGymCell(in_gym: gym)
            return cell
        }
        else {
            return GymCell()
        }
    }
}
