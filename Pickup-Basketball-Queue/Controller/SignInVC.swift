//
//  SignInVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/17/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var playerSignInBtn: UIButton!
    @IBOutlet weak var gymSignInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerSignInBtn.layer.cornerRadius = 10
        gymSignInBtn.layer.cornerRadius = 10
    }

}
