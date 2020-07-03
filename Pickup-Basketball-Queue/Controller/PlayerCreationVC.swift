//
//  PlayerCreationVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/24/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class PlayerCreationVC: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profilePicBtn: UIButton!
    @IBOutlet weak var profilePicImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneBtn.layer.cornerRadius = 15
        profilePicImage.layer.cornerRadius = 77
        profilePicBtn.layer.cornerRadius = 77
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    @IBAction func profilePicBtnPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        if let playerUsername = usernameTextField.text, let profilePic = profilePicImage.image {
            DataService.instance.savePlayerWithImage(username: playerUsername, image: profilePic, queuePosition: -1)
            self.performSegue(withIdentifier: "PlayerCreationViewtoPlayerDashboardView", sender: nil)
        }
        else {
            showAlert(title: "Error", message: "Please make sure you have entered a username and selected a profile image")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        profilePicImage.image = selectedImage
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
