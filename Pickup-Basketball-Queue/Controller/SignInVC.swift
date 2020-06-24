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
            if(AuthService.instance.isGym) {
                performSegue(withIdentifier: "SignInViewtoGymView", sender: nil)
            }
            else {
                performSegue(withIdentifier: "SignInViewtoPlayerView", sender: nil)
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
                AuthService.instance.isLoggedIn = true
                if AuthService.instance.firstTime {
                    self.performSegue(withIdentifier: "SignInViewtoPlayerCreationView", sender: nil)
                }
                else {
                    self.performSegue(withIdentifier: "SignInViewtoPlayerView", sender: nil)
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
                AuthService.instance.isGym = true
                if AuthService.instance.firstTime {
                    self.performSegue(withIdentifier: "SignInViewtoGymCreationView", sender: nil)
                }
                else {
                    self.performSegue(withIdentifier: "SignInViewtoGymView", sender: nil)
                }
            }
            else {
                self.showAlert(title: "Failure", message: message)
            }
        }
    }
    
    
}
