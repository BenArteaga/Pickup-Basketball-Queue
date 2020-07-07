//
//  GymVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/19/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class GymVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func LogOutBtnPressed(_ sender: UIButton) {
        do {
            try Firebase.Auth.auth().signOut()
            AuthService.instance.isLoggedIn = false
            performSegue(withIdentifier: "GymViewtoSignInView", sender: nil)
        } catch {
            print("An error occured signing out")
        }
    }
    
}
