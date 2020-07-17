//
//  PlayerVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/19/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class QueueVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var playerQueue: UITableView!
    @IBOutlet weak var getOnQueueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOnQueueBtn.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @IBAction func LogOutBtnPressed(_ sender: UIButton) {
        do {
            try Firebase.Auth.auth().signOut()
            AuthService.instance.isLoggedIn = false
            performSegue(withIdentifier: "PlayerViewtoSignInView", sender: nil)
        } catch {
            print("An error occured signing out")
        }
    }
    
}
