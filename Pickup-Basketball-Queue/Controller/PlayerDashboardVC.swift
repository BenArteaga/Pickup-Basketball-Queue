//
//  PlayerDashboardVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/30/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class PlayerDashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addGymBtn: UIButton!
    
    //View of all the gyms that the player has added to their dashboard
    @IBOutlet weak var playerGymsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerGymsTableView.delegate = self
        playerGymsTableView.dataSource = self

        addGymBtn.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @IBAction func addGymBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        do {
            try Firebase.Auth.auth().signOut()
            AuthService.instance.isLoggedIn = false
            performSegue(withIdentifier: "PlayerViewtoSignInView", sender: nil)
        } catch {
            print("An error occured signing out")
        }
    }
    
}
