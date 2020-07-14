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

class DataService {
    static let instance = DataService()
    //array to be filled with all of the possible gyms that a player could start following
    var gymsToAdd: [Gym] = []
    //array to be filled with the gyms that the player is currently following
    var gymsFollowing: [Gym] = []
    
    //saves player to FirebaseDatabase in the form of a dictionary
    func savePlayer(username: String?, imagePath: String?, queuePosition: Int?) {
        let userID = Auth.auth().currentUser!.uid
        //it should be okay to force unwrap because this function should never be called with empty values
        let player = ["player": username!, "image": imagePath!, "position": queuePosition!] as [String : Any]
        let playerRef = Database.database().reference().child("players").child(userID)
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
        let gymRef = Database.database().reference().child("gyms").child(userID)
        gymRef.updateChildValues(gym)
    }
    
    //updates the following and followers root nodes of the database when a player wants to add a gym to their dashboard
    func followGym(in_gym: Gym) {
        let currentUID = Auth.auth().currentUser!.uid
        //"followers" is a root node where the children are gyms and the next children are players who follow that gym
        //"following" is a root node where the children are players and the next children are all the gyms that the player follows
        let followData = ["followers/\(in_gym.gymID ?? "")/\(currentUID)": true, "following/\(currentUID)/\(in_gym.gymID ?? "")": true]
        let ref = Database.database().reference()
        ref.updateChildValues(followData)
    }
    
    //loads gyms that playing is following and stores them in an array
    func loadGymsFollowing(_ completion: @escaping ([Gym]) -> Void) {
        gymsFollowing.removeAll()
        let ref = Database.database().reference().child("following").child(Auth.auth().currentUser!.uid)
        
        ref.observeSingleEvent(of: .value, with: { data in
            guard let allGyms = data.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let dispatchGroup = DispatchGroup()
            
            for gymData in allGyms {
                dispatchGroup.enter()
                self.getGymForGymID(in_gymID: gymData.key) { (gym) in
                    if let newGym = gym {
                        self.gymsFollowing.append(newGym)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(self.gymsFollowing)
            })
        })
    }
    
    //function to check if a user follows a gym which will be used when we display gyms for the user to add
    func isFollowingGym(gymKey: String, completion: @escaping (Bool) -> Void) {
        let currentUID = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("following").child(currentUID)
        
        ref.child(gymKey).observeSingleEvent(of: .value, with: { (data) in
            if let isFollowing = data.value as? Bool {
                completion(true)
            }
            else {
                completion(false)
            }
        })
    }
    
    //loads messages from Firebase and stores the in messages array
//    func loadGymsToAdd(_ completion: @escaping (_ Success: Bool) -> Void) {
//        //observes the value of that Firebase location
//        let ref = Database.database().reference().child("gyms")
//        ref.observe(.value) { (data: Firebase.DataSnapshot) in
//            if data.value != nil {
//                self.gymsToAdd = Gym.gymArrayFromFBData(fbData: data.value! as AnyObject)
//                self.delegate?.dataLoaded()
//                if self.gymsToAdd.count > 0 {
//                    completion(true)
//                }
//                else {
//                    completion(false)
//                }
//            }
//            else {
//                completion(false)
//            }
//        }
//    }
    
    func loadGymsToAdd2(completion: @escaping ([Gym]) -> Void) {
        self.gymsToAdd.removeAll()
        let ref = Database.database().reference().child("gyms")
    
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let allGyms = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
    
    
            let dispatchGroup = DispatchGroup()
            for gymData in allGyms {
                dispatchGroup.enter()
                let gym = Gym(in_gymID: gymData.key, gymData: gymData.value as! Dictionary<String, AnyObject>)
    
                self.isFollowingGym(gymKey: gymData.key) { (isFollowing) in
                    if !isFollowing {
                        self.gymsToAdd.append(gym)
                    }
                    dispatchGroup.leave()
                }
            }
    
            dispatchGroup.notify(queue: .main, execute: {
                completion(self.gymsToAdd)
            })
        })
    }
    
    //function to fetch a gym object using a gymID
    func getGymForGymID(in_gymID: String, completion: @ escaping (Gym?) -> Void) {
        let ref = Database.database().reference().child("gyms").child(in_gymID)
        
        ref.observeSingleEvent(of: .value, with: { (data) in
            let gym = Gym(in_gymID: in_gymID, gymData: data.value as! Dictionary<String, AnyObject>)
            completion(gym)
        })
        
    }
    
    //function to get a player by their playerID
    func getPlayerforPlayerID(in_playerID: String, completion: @ escaping (Player?) -> Void) {
        let ref = Database.database().reference().child("players").child(in_playerID)
        ref.observeSingleEvent(of: .value, with: { (data) in
            let player = Player(in_playerID: in_playerID, playerData: data.value as! Dictionary<String, AnyObject>)
            completion(player)
        })
    }
}
