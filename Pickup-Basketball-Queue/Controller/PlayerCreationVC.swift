//
//  PlayerCreationVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/24/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit

class PlayerCreationVC: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profilePicBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    @IBAction func profilePicBtnPressed(_ sender: UIButton) {
        let imgPath = 
        DataService.instance.savePlayer(username: usernameTextField.text, imagePath: <#T##String?#>, queuePosition: <#T##Int?#>)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        profilePicBtn.imageView?.image = selectedImage
    }
    
}
