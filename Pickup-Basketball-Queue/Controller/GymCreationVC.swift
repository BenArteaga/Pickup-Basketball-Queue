//
//  GymCreationVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/24/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class GymCreationVC: UIViewController {
    @IBOutlet weak var gymNameTextField: UITextField!
    @IBOutlet weak var numCourtsTextField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneBtn.layer.cornerRadius = 15
    }

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        
    }
}
