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
    //array to be filled with all of the possible gyms that a player could start following
    var gymsToAdd: [Gym] = []
    weak var delegate: DataServiceDelegate?
    
    //saves player to FirebaseDatabase in the form of a dictionary
    func savePlayer(username: String?, imagePath: String?, queuePosition: Int?) {
        let userID = Auth.auth().currentUser!.uid
        //it should be okay to force unwrap because this function should never be called with empty values
        let player = ["player": username!, "image": imagePath!, "position": queuePosition!] as [String : Any]
        let playerRef = Database.database().reference().child("players").child(userID).childByAutoId()
        playerRef.updateChildValues(player)
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
    
    //saves gym to Firebase in the form of a dictionary
    func saveGym(gymName: String?, numOfCourts: Int?) {
        let userID = Auth.auth().currentUser!.uid
        let gym = ["gym": gymName!, "courtCount": numOfCourts!] as [String : Any]
        let gymRef = Database.database().reference().child("gyms").child(userID).childByAutoId()
        gymRef.updateChildValues(gym)
    }
    
    //updates the following and followers root nodes of the database when a player wants to add a gym to their dashboard
    func followGym(user: User) {
        let currentUID = Auth.auth().currentUser!.uid
        //"followers" is a root node where the children are gyms and the next children are players who follow that gym
        //"following" is a root node where the children are players and the next children are all the gyms that the player follows
        let followData = ["followers/\(user.uid)/\(currentUID)": true, "following/\(currentUID)/\(user.uid)": true]
        let ref = Database.database().reference()
        ref.updateChildValues(followData)
    }
    
    //function to check if a user follows a gym which will be used when we display gyms for the user to add
    func isFollowingGym(gymKey: String) -> Bool {
        let currentUID = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("following").child(currentUID)
        var isFollowing = false
        ref.child(gymKey).observe(.value) { (data: Firebase.DataSnapshot) in
            if data.value != nil {
                isFollowing = true
            }
        }
        return isFollowing
    }
    
    //loads messages from Firebase and stores the in messages array
    func loadGymsToAdd(_ completion: @escaping (_ Success: Bool) -> Void) {
        //observes the value of that Firebase location
        let ref = Database.database().reference().child("gyms")
        ref.observe(.value) { (data: Firebase.DataSnapshot) in
            if data.value != nil {
                self.gymsToAdd = Gym.gymArrayFromFBData(fbData: data.value! as AnyObject)
                self.delegate?.dataLoaded()
                if self.gymsToAdd.count > 0 {
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
            else {
                completion(false)
            }
        }
    }
}
