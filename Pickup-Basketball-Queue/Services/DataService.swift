//
//  DataService.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/22/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase.FIRDataSnapshot
import FirebaseStorage

protocol DataServiceDelegate: class {
    func dataLoaded()
}

class DataService {
    static let instance = DataService()
    var players: [Player] = []
    weak var delegate: DataServiceDelegate?
    
    //saves player to FirebaseDatabase in the form of a dictionary
    func savePlayer(username: String?, imagePath: String?, queuePosition: Int?) {
        let userID = Auth.auth().currentUser!.uid
        let player = ["player": username ?? "", "image": imagePath ?? "", "position": queuePosition ?? 0] as [String : Any]
        let playerRef = Database.database().reference().child("players").child(userID).childByAutoId
        playerRef().updateChildValues(player)
    }
    
    //saves image to FirebaseStorage and then calls savePlayer with the imageUrl as a string
    func savePlayerWithImage(username: String?, image: UIImage, queuePosition: Int?) {
        let userID = Auth.auth().currentUser!.uid
        let imageRef = Storage.storage().reference().child(userID)
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            let urlString = downloadURL.absoluteString
            self.savePlayer(username: username, imagePath: urlString, queuePosition: queuePosition)
        }
    }
    
//    func imageForPath(_ path: String) -> UIImage? {
//        let fullPath = documentsPathForFileName(path)
//        let image = UIImage(named: fullPath)
//        return image
//    }
//
//    func documentsPathForFileName(_ name: String) -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let fullPath = paths[0] as NSString
//        return fullPath.appendingPathComponent(name)
//    }
//
//    func saveImageAndCreatePath(_ image: UIImage) -> String {
//        //turns image into data
//        let imgData = image.pngData()
//        //makes sure that each time we save an image it will have a unique path name
//        let imgPath = "image\(Date.timeIntervalSinceReferenceDate).png"
//        let fullPath = documentsPathForFileName(imgPath)
//        //writes fullPath to disc
//        try? imgData?.write(to: URL(fileURLWithPath: fullPath), options: [.atomic])
//        //not sure why we are returning imgPath?
//        return imgPath
//    }
}
