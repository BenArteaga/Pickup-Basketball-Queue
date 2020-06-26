//
//  PlayerCreationVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/24/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class PlayerCreationVC: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profilePicBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicBtn.imageView?.layer.cornerRadius = 77
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    @IBAction func profilePicBtnPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        profilePicBtn.imageView?.image = selectedImage
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
