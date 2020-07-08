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
        if let gym = gymNameTextField.text, let numCourts = Int(numCourtsTextField.text!) {
            DataService.instance.saveGym(gymName: gym, numOfCourts: numCourts)
            CourtService.instance.saveCourts(in_numCourts: numCourts)
            self.performSegue(withIdentifier: "GymCreationViewtoGymView", sender: nil)
        }
        else {
            showAlert(title: "Error", message: "Please make sure you have entered a valid gym name and valid number of courts (e.g. 1, 2, 3)" )
        }
    }
    
    //if user touches return, keyboard goes away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //if user touches outside of keyboard, keyboard goes away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //takes a title and message and uses them to create and show a custom alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
