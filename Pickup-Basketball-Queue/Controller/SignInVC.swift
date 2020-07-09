//
//  SignInVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/17/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var playerSignInBtn: UIButton!
    @IBOutlet weak var gymSignInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerSignInBtn.layer.cornerRadius = 10
        gymSignInBtn.layer.cornerRadius = 10
    }

    //if a user is already logged in, this function will grab the username and skip the login page, going straight to either the player page or gym page
     override func viewDidAppear(_ animated: Bool) {
        if Firebase.Auth.auth().currentUser != nil {
            let userID = (Auth.auth().currentUser?.uid)!
            AuthService.instance.isGym(in_uid: userID) { (isGym) in
                if isGym {
                    self.performSegue(withIdentifier: "SignInViewtoGymDashboardView", sender: nil)
                }
                else {
                    self.performSegue(withIdentifier: "SignInViewtoPlayerDashboardView", sender: nil)
                }
            }
        }
     }
     
     //takes a title and message and uses them to create and show a custom alert
     func showAlert(title: String, message: String) {
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(okAction)
         self.present(alertController, animated: true, completion: nil)
     }
    
    @IBAction func playerSignInTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "Please enter an email and a password")
            return
        }
        
        guard email != "", password != "" else {
            showAlert(title: "Error", message: "Please enter an email and password")
            return
        }
        
        AuthService.instance.emailLogin(email, password: password) { (success, message) in
            if success {
                AuthService.instance.email = self.emailTextField.text
                AuthService.instance.isLoggedIn = true
                if AuthService.instance.firstTime {
                    AuthService.instance.saveGymOrPlayer(in_isGym: false)
                    self.performSegue(withIdentifier: "SignInViewtoPlayerCreationView", sender: nil)
                }
                else {
                    AuthService.instance.isGym(in_uid: Auth.auth().currentUser!.uid) { (isGym) in
                        if isGym {
                            self.showAlert(title: "Error", message: "It appears you already have a gym account and you cannot create both a gym and player account under the same credentials")
                        }
                        else {
                            self.performSegue(withIdentifier: "SignInViewtoPlayerDashboardView", sender: nil)
                        }
                    }
                }
            }
            else {
                self.showAlert(title: "Failure", message: message)
            }
        }
    }
    
    @IBAction func gymSignInTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "Please enter an email and a password")
            return
        }
        
        guard email != "", password != "" else {
            showAlert(title: "Error", message: "Please enter an email and password")
            return
        }
        
        AuthService.instance.emailLogin(email, password: password) { (success, message) in
            if success {
                AuthService.instance.isLoggedIn = true
                if AuthService.instance.firstTime {
                    AuthService.instance.saveGymOrPlayer(in_isGym: true)
                    self.performSegue(withIdentifier: "SignInViewtoGymCreationView", sender: nil)
                }
                else {
                    AuthService.instance.isGym(in_uid: Auth.auth().currentUser!.uid) { (isGym) in
                        if isGym {
                            self.performSegue(withIdentifier: "SignInViewtoGymDashboardView", sender: nil)
                        }
                        else {
                            self.showAlert(title: "Error", message: "It appears you already have a player account and you cannot make both a gym and player account under the same credentials")
                        }
                    }
                }
            }
            else {
                self.showAlert(title: "Failure", message: message)
            }
        }
    }
}
